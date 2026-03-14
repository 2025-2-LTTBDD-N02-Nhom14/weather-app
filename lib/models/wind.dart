class Wind {
  final double speed;
  final String unit;
  final String direction;

  Wind({
    required this.speed,
    required this.unit,
    required this.direction,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: double.parse(json['speed']),
      unit: json['unit'],
      direction: json['direction'],
    );
  }
}
