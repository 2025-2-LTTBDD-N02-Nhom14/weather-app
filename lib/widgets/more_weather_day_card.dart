import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auth_profile_app/widgets/weather_card.dart';
import 'package:auth_profile_app/models/weather_model.dart';
import 'package:auth_profile_app/localization/app_localizations.dart';
import 'package:auth_profile_app/providers/languague_provider.dart';

class MoreSevenDayCard extends StatelessWidget {
  final WeatherModel data;

  const MoreSevenDayCard({
    super.key,
    required this.data,
  });

  String _formatDay(DateTime date, int index) {
    if (index == 0) return "Today";

    const days = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];
    return days[date.weekday - 1];
  }

  IconData _mapIcon(String desc) {
    switch (desc.toLowerCase()) {
      case "rainy":
        return Icons.cloudy_snowing;
      case "cloudy":
        return Icons.cloud;
      case "sunny":
        return Icons.wb_sunny;
      case "cool":
        return Icons.ac_unit;
      default:
        return Icons.wb_sunny;
    }
  }

  @override
  Widget build(BuildContext context) {
    final forecast = data.fiveDayForecast;
    final languageProvider = context.read<LanguageProvider>();
    final loc = AppLocalizations.of(context);
    return WeatherCard(
      title: loc.tr('seven_day_forecast'),
      child: Column(
        children: List.generate(forecast.length, (index) {
          final item = forecast[index];

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      _formatDay(item.date, index),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        _mapIcon(item.weatherDescription),
                        size: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 12),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_upward,
                            size: 16,
                          ),
                          Text(
                            "${item.maxTemperature}°",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        "/",
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(width: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_downward,
                            size: 16,
                          ),
                          Text(
                            "${item.minTemperature}°",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              if (index != forecast.length - 1)
                Divider(
                  height: 20,
                  color: Colors.white.withOpacity(0.08),
                ),
            ],
          );
        }),
      ),
    );
  }
}
