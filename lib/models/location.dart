class Location {
  final String city;
  final String country;
  final double latitude;
  final double longitude;

  Location({
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['city'],
      country: json['country'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
    );
  }
}
