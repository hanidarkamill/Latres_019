import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<dynamic>> fetchData(String endpoint) async {
    final url = Uri.parse('https://api.spaceflightnewsapi.net/v4/$endpoint');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['results'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Map<String, dynamic>> fetchDetail(String endpoint, int id) async {
    final url = Uri.parse('https://api.spaceflightnewsapi.net/v4/$endpoint/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load detail');
    }
  }
}
