import 'dart:math';
import 'package:flutter/material.dart';

class DailyForecast {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final int humidity;
  final int cloudCover;
  final int uvIndex;

  DailyForecast({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.cloudCover,
    required this.uvIndex,
  });
}

class MoreSevenDayChart extends StatelessWidget {
  final List<DailyForecast> data;

  const MoreSevenDayChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    final sorted = [...data]..sort(
        (a, b) => a.date.compareTo(b.date),
      );

    final next7 = sorted.take(8).toList();

    return Column(
      children: next7.map((item) {
        final rain = _generateRain(item);
        final icon = _weatherIcon(item, rain);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                child: Text(
                  _weekdayLabel(item.date),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.water_drop,
                          size: 18,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${rain.toInt()}%",
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          icon,
                          size: 20,
                        ),
                      ],
                    ),
                    Text(
                      "${item.minTemp.toInt()}° / ${item.maxTemp.toInt()}°",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _weekdayLabel(DateTime date) {
    switch (date.weekday) {
      case 1:
        return "T2";
      case 2:
        return "T3";
      case 3:
        return "T4";
      case 4:
        return "T5";
      case 5:
        return "T6";
      case 6:
        return "T7";
      case 7:
        return "CN";
      default:
        return "";
    }
  }

  double _generateRain(DailyForecast item) {
    final random = Random(item.date.day * 37);

    final hasRain =
        item.cloudCover > 60 && item.humidity > 70 && item.uvIndex < 5;

    if (!hasRain) {
      return random.nextDouble() * 9 + 1;
    }

    double chance = (item.cloudCover - 50) * 0.6 + (item.humidity - 60) * 0.4;

    chance += random.nextDouble() * 10;

    return chance.clamp(5, 95);
  }

  IconData _weatherIcon(DailyForecast item, double rain) {
    if (rain > 70) return Icons.thunderstorm;
    if (rain > 40) return Icons.grain;
    if (item.uvIndex > 6 && item.cloudCover < 40) return Icons.wb_sunny;

    return Icons.cloud;
  }
}
