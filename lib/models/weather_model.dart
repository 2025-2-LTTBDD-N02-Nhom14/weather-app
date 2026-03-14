import 'location.dart';
import 'current_weather.dart';
import 'seven_day_forecast.dart';
import 'twenty_four_hour_forecast.dart';

class WeatherModel {
  final Location location;
  final CurrentWeather currentWeather;
  final List<FiveDayForecast> fiveDayForecast;
  final List<TwentyFourHourForecast> twentyFourHourForecast;
  final DateTime dataFetchedAt;

  WeatherModel({
    required this.location,
    required this.currentWeather,
    required this.fiveDayForecast,
    required this.twentyFourHourForecast,
    required this.dataFetchedAt,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: Location.fromJson(json['location']),
      currentWeather: CurrentWeather.fromJson(json['currentWeather']),
      fiveDayForecast: (json['fiveDayForecast'] as List)
          .map((e) => FiveDayForecast.fromJson(e))
          .toList(),
      twentyFourHourForecast: (json['twentyFourHourForecast'] as List)
          .map((e) => TwentyFourHourForecast.fromJson(e))
          .toList(),
      dataFetchedAt: DateTime.parse(json['dataFetchedAt']),
    );
  }
}
