import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'services/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await SharedPrefs.getLoginStatus();
  final username = await SharedPrefs.getUsername();
  runApp(MyApp(isLoggedIn: isLoggedIn, username: username));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String username;

  const MyApp({required this.isLoggedIn, required this.username, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isLoggedIn ? HomePage(username: username) : const LoginPage(),
    );
  }
}
