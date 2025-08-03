import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Domain/Entities/location.dart';

class WeatherAPIDataSource {
  WeatherAPIDataSource({required this.client, required this.apiKey});

  final http.Client client;
  final String apiKey; //TODO hide secret

  Future<Map<String, dynamic>> fetchWeather(Location location) async {
    final query = '${location.latitude}, ${location.longitude}';
    final uri = Uri.parse(
      'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$query&aqi=no',
    );
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json;
    } else {
      throw Exception('Error al obtener el clima> ${response.statusCode}');
    }
  }
}
