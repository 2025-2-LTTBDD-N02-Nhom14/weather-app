import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:auth_profile_app/localization/app_localizations.dart';
import 'package:auth_profile_app/providers/languague_provider.dart';
import 'package:provider/provider.dart';

class LocationCard extends StatelessWidget {
  final String city;
  final String country;
  final int temperature;
  final int minTemp;
  final int maxTemp;
  final String description;
  final DateTime time;
  final VoidCallback? onTap;

  const LocationCard({
    super.key,
    required this.city,
    required this.country,
    required this.temperature,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.time,
    this.onTap,
  });

  IconData getWeatherIcon() {
    switch (description.toLowerCase()) {
      case "sunny":
        return Icons.wb_sunny;
      case "rainy":
        return Icons.cloudy_snowing;
      case "cloudy":
        return Icons.cloud;
      default:
        return Icons.wb_cloudy;
    }
  }

  Color getWeatherColor() {
    switch (description.toLowerCase()) {
      case "sunny":
        return Colors.orange;
      case "rainy":
        return Colors.blue;
      case "cloudy":
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat("HH:mm  dd/MM/yyyy").format(time);
    final languageProvider = context.read<LanguageProvider>();
    final loc = AppLocalizations.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  country,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  loc.tr('at') + "$formattedTime",
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      getWeatherIcon(),
                      color: getWeatherColor(),
                      size: 36,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "$temperature°",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "$minTemp° / $maxTemp°",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
