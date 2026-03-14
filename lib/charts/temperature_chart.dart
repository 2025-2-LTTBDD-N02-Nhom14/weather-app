import 'dart:math';
import 'package:flutter/material.dart';

class HourlyForecast {
  final DateTime time;
  final double feelsLike;
  final int cloudCover;
  final int humidity;
  final int uvIndex;

  HourlyForecast({
    required this.time,
    required this.feelsLike,
    required this.cloudCover,
    required this.humidity,
    required this.uvIndex,
  });
}

class ChartPoint {
  final String hourLabel;
  final double temperature;
  final double normalizedY;
  final bool isSunny;
  final double precipitation;

  ChartPoint({
    required this.hourLabel,
    required this.temperature,
    required this.normalizedY,
    required this.isSunny,
    required this.precipitation,
  });
}

class ChartSegment {
  final ChartPoint start;
  final ChartPoint end;
  final Color segmentColor;

  ChartSegment({
    required this.start,
    required this.end,
    required this.segmentColor,
  });
}

class TemperatureChartLogic {
  static List<ChartPoint> buildChart(List<HourlyForecast> data) {
    if (data.isEmpty) return [];

    final maxTemp = data.map((e) => e.feelsLike).reduce(max);
    final minTemp = data.map((e) => e.feelsLike).reduce(min);
    final range = (maxTemp - minTemp == 0) ? 1 : maxTemp - minTemp;

    return data.map((item) {
      final normalized = (item.feelsLike - minTemp) / range;
      final rain = _generateRain(item);
      final sunny = _isSunny(item, rain);

      return ChartPoint(
        hourLabel: "${item.time.hour}:00",
        temperature: item.feelsLike,
        normalizedY: normalized,
        isSunny: sunny,
        precipitation: rain,
      );
    }).toList();
  }

  static List<ChartSegment> buildSegments(List<ChartPoint> points) {
    if (points.length < 2) return [];

    List<ChartSegment> segments = [];

    for (int i = 0; i < points.length - 1; i++) {
      final start = points[i];

      Color color;

      if (start.precipitation > 70) {
        color = Colors.white;
      } else if (start.isSunny) {
        color = Colors.yellow;
      } else {
        color = Colors.white;
      }

      segments.add(
        ChartSegment(
          start: start,
          end: points[i + 1],
          segmentColor: color,
        ),
      );
    }

    return segments;
  }

  static double _generateRain(HourlyForecast item) {
    final hour = item.time.hour;
    final random = Random(hour * 97);

    double chance = 0;

    final hasRainCondition =
        item.cloudCover > 65 && item.humidity > 70 && item.uvIndex < 5;

    if (!hasRainCondition) {
      return random.nextDouble() * 9 + 1;
    }

    chance += (item.cloudCover - 60) * 0.6;
    chance += (item.humidity - 65) * 0.5;

    if (hour >= 14 && hour <= 18) {
      chance += 10;
    }

    chance += random.nextDouble() * 8;

    return chance.clamp(5, 95);
  }

  static bool _isSunny(HourlyForecast item, double rainPercent) {
    final hour = item.time.hour;

    if (hour < 6 || hour > 17) return false;
    if (rainPercent > 60) return false;

    if (hour >= 6 && hour <= 11) {
      return item.cloudCover < 40;
    }

    if (hour >= 12 && hour <= 14) {
      return item.uvIndex >= 6;
    }

    return false;
  }
}

class TemperatureChartPainter extends CustomPainter {
  final List<ChartPoint> points;

  TemperatureChartPainter(this.points);

  static const double itemWidth = 60;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final segments = TemperatureChartLogic.buildSegments(points);

    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < segments.length; i++) {
      final startX = i * itemWidth + itemWidth / 2;
      final endX = (i + 1) * itemWidth + itemWidth / 2;

      final startY =
          size.height - (segments[i].start.normalizedY * size.height);

      final endY = size.height - (segments[i].end.normalizedY * size.height);

      final paint = Paint()
        ..color = segments[i].segmentColor
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }

    for (int i = 0; i < points.length; i++) {
      final x = i * itemWidth + itemWidth / 2;

      final y = size.height - (points[i].normalizedY * size.height);

      canvas.drawCircle(
        Offset(x, y),
        4,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
