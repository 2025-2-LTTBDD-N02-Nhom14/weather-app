class TwentyFourHourForecast {
  final DateTime time;
  final int feelsLike;

  TwentyFourHourForecast({
    required this.time,
    required this.feelsLike,
  });

  factory TwentyFourHourForecast.fromJson(Map<String, dynamic> json) {
    return TwentyFourHourForecast(
      time: DateTime.parse(json['time']),
      feelsLike: json['feelsLike'],
    );
  }
}
