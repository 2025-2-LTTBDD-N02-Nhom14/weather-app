import 'package:auth_profile_app/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:auth_profile_app/models/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  List<WeatherModel> _cities = [];

  List<WeatherModel> get cities => _cities;

  final WeatherService _weatherService = WeatherService();

  Future<void> loadDefaultAddress() async {
    if (_cities.isNotEmpty) return;

    final weather = await WeatherService().fetchWeatherByAddress("Ha Noi");
    cities.add(weather);
    notifyListeners();
  }

  void addCity(WeatherModel city) {
    _cities.add(city);
    notifyListeners();
  }

  void removeCity(WeatherModel city) {
    _cities.remove(city);
    notifyListeners();
  }

  void setCities(List<WeatherModel> newCities) {
    _cities = newCities;
    notifyListeners();
  }
}
