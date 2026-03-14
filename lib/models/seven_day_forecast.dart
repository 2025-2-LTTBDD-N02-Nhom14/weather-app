class FiveDayForecast {
  final DateTime date;
  final int maxTemperature;
  final int minTemperature;
  final String weatherDescription;

  FiveDayForecast({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.weatherDescription,
  });

  factory FiveDayForecast.fromJson(Map<String, dynamic> json) {
    return FiveDayForecast(
      date: DateTime.parse(json['date']),
      maxTemperature: json['maxTemperature'],
      minTemperature: json['minTemperature'],
      weatherDescription: json['weatherDescription'],
    );
  }
}
