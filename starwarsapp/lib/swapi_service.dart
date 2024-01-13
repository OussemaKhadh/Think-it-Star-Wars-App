import 'dart:convert';
import 'package:http/http.dart' as http;

class SwapiService {
  final String baseUrl = 'https://swapi.dev/api';

  Future<List<Map<String, dynamic>>> getFilms() async {
    final response = await http.get(Uri.parse('$baseUrl/films/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      return List<Map<String, dynamic>>.from(data);
      
    } else {
      throw Exception('Failed to load films');
    }
  }
}



