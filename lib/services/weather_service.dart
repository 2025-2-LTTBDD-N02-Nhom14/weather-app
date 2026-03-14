import 'dart:convert';
import 'package:auth_profile_app/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:diacritic/diacritic.dart';

class WeatherService {
  static const String baseUrl = "http://localhost:3000";

  Future<WeatherModel> fetchWeatherByAddress(String address) async {
    final normalizedAddress = removeDiacritics(address);

    final uri =
        Uri.parse("$baseUrl/api/weather/address").replace(queryParameters: {
      "address": normalizedAddress,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception("Failed to load weather");
    }
  }
}
