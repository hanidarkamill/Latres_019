import 'package:flutter/material.dart';
import 'list_page.dart';
import 'login_page.dart'; // Assuming the login page is named LoginPage

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({required this.username, super.key});

  @override
  Widget build(BuildContext context) {
    void logout() async {
      // Not clearing SharedPreferences data, just navigating to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),  // Navigate to login page
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $username'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),  // Black logout icon
            onPressed: logout,
          ),
        ],
        backgroundColor: Colors.blue[800],  // Navy blue app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[800]!, Colors.white], // Blue to white gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                // Button for News
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ListPage(category: 'articles')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.blue[800],  // Navy blue button
                    foregroundColor: Colors.white,  // White text for contrast
                    shadowColor: Colors.blue,  // Blue shadow
                    elevation: 5,
                  ),
                  child: const Text(
                    'News',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                // Button for Blogs
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ListPage(category: 'blogs')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.blue[800],  // Navy blue button for consistency
                    foregroundColor: Colors.white,  // White text
                    shadowColor: Colors.blue, // Blue shadow
                    elevation: 5,
                  ),
                  child: const Text(
                    'Blogs',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                // Button for Reports
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ListPage(category: 'reports')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.blue[800],  // Navy blue button for consistency
                    foregroundColor: Colors.white,  // White text
                    shadowColor: Colors.blue, // Blue shadow
                    elevation: 5,
                  ),
                  child: const Text(
                    'Reports',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
