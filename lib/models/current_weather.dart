import 'wind.dart';

class CurrentWeather {
  final int temperature;
  final String unit;
  final int humidity;
  final int pressure;
  final int maxTemperature;
  final int minTemperature;
  final int uvIndex;
  final int feelsLike;
  final Wind wind;
  final int cloudCover;
  final String weatherDescription;
  final DateTime sunrise;
  final DateTime sunset;

  CurrentWeather({
    required this.temperature,
    required this.unit,
    required this.humidity,
    required this.pressure,
    required this.maxTemperature,
    required this.minTemperature,
    required this.uvIndex,
    required this.feelsLike,
    required this.wind,
    required this.cloudCover,
    required this.weatherDescription,
    required this.sunrise,
    required this.sunset,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: json['temperature'],
      unit: json['unit'],
      humidity: json['humidity'],
      pressure: json['pressure'],
      maxTemperature: json['maxTemperature'],
      minTemperature: json['minTemperature'],
      uvIndex: json['uvIndex'],
      feelsLike: json['feelsLike'],
      wind: Wind.fromJson(json['wind']),
      cloudCover: json['cloudCover'],
      weatherDescription: json['weatherDescription'],
      sunrise: DateTime.parse(json['sunrise']),
      sunset: DateTime.parse(json['sunset']),
    );
  }
}
