import 'package:flutter/material.dart';
import 'package:latres/services/api_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'detail_page.dart';

class ListPage extends StatefulWidget {
  final String category;

  const ListPage({required this.category, super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<dynamic>> _data;

  @override
  void initState() {
    super.initState();
    _data = ApiService.fetchData(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of ${widget.category.capitalize()}'),
        backgroundColor: Colors.blue[800], // Navy blue app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[800]!, Colors.white], // Navy blue to white gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<List<dynamic>>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available.'));
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                final imageUrl = item['image_url'];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 8, // Slightly less elevation for a cleaner look
                  color: Colors.blue[800], // Navy blue background for the card
                  child: ListTile(
                    leading: imageUrl != null && Uri.parse(imageUrl).isAbsolute
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.image_not_supported, size: 60, color: Colors.grey),
                            ),
                          )
                        : const Icon(Icons.image_not_supported, size: 60, color: Colors.grey),
                    title: Text(
                      item['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White title text
                      ),
                    ),
                    subtitle: Text(
                      item['summary'] ?? 'No summary available',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70, // Lighter text color for subtitle
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            category: widget.category,
                            id: item['id'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// Extension untuk memulai huruf besar pada kategori
extension StringExtension on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}
