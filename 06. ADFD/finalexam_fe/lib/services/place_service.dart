import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/place.dart';

class PlaceService {
  static const String baseUrl = 'http://10.24.31.99:8080/api';
  static const String imageBaseUrl = 'http://10.24.31.99:8080'; // same backend

  Future<List<Place>> getAllPlace() async {
    final response = await http.get(Uri.parse('$baseUrl/places'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((e) {
        final place = Place.fromJson(e);
        // 🔗 make full URL if only relative path stored
        if (!place.imageUrl.startsWith('http')) {
          place.imageUrl = '$imageBaseUrl${place.imageUrl}';
        }
        return place;
      }).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }
}
