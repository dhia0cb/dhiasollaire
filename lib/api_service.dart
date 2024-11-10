import 'dart:convert';
import 'package:http/http.dart' as http;
import 'planet.dart';

class ApiService {
  final String apiUrl = 'http://10.0.2.2:3000/api/planets'; // L'URL de votre API Node.js

  Future<List<Planet>> fetchPlanets() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Planet.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load planets');
    }
  }
}
