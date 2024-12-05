import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> saveUser(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('password', password);
  }

  static Future<void> setLoginStatus(bool status, String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', status);
    prefs.setString('username', username);
  }

  static Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? '';
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<bool> validateUser(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username');
    final savedPassword = prefs.getString('password');
    return username == savedUsername && password == savedPassword;
  }
}
