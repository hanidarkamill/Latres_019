import 'package:flutter/material.dart';
import 'package:latres/pages/list_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latres/services/api_services.dart';

class DetailPage extends StatelessWidget {
  final String category;
  final int id;

  const DetailPage({required this.category, required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.capitalize()} Detail'),
        backgroundColor: Colors.blue[800], // Navy blue app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[800]!, Colors.white],  // Navy blue to white gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<Map<String, dynamic>>(
          future: ApiService.fetchDetail(category, id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No data available.'));
            }

            final data = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Gambar Header
                  data['image_url'] != null
                      ? Container(
                          width: double.infinity,
                          height: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(data['image_url']),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                        )
                      : const SizedBox(
                          height: 250,
                          child: Center(
                            child: Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
                          ),
                        ),
                  
                  // Konten Detail
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Judul
                        Text(
                          data['title'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // White title to stand out
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Deskripsi / Ringkasan
                        Text(
                          data['summary'] ?? 'No summary available',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70, // Lighter text for description
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Tombol Aksi: Baca Artikel (Eye-catching button)
                        ElevatedButton.icon(
                          onPressed: () async {
                            final url = Uri.parse(data['url']);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Could not launch URL')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                            backgroundColor: Colors.blue[800], // Navy blue button
                            foregroundColor: Colors.white, // White text
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            elevation: 8, // Slight shadow for elevation
                            shadowColor: Colors.blue[700], // Blue shadow
                          ),
                          icon: const Icon(
                            Icons.article_outlined,
                            size: 30, // Icon size for better visibility
                          ),
                          label: const Text(
                            'Read Full Article',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
