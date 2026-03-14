import 'package:flutter/material.dart';
import 'package:auth_profile_app/charts/temperature_chart.dart';
import 'package:auth_profile_app/widgets/weather_card.dart';
import 'package:auth_profile_app/localization/app_localizations.dart';

class ChartTemperatureCard extends StatelessWidget {
  final List<HourlyForecast> hourlyData;
  final String? title;

  ChartTemperatureCard({
    super.key,
    required this.hourlyData,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final chartPoints = TemperatureChartLogic.buildChart(hourlyData);

    const double itemWidth = 60;

    return WeatherCard(
      title: title ?? AppLocalizations.of(context).tr('hour_forecast'),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: chartPoints.length * itemWidth,
          child: Column(
            children: [
              Row(
                children: chartPoints.map((p) {
                  return SizedBox(
                    width: itemWidth,
                    child: Center(
                      child: Text(
                        p.hourLabel,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              Row(
                children: chartPoints.map((p) {
                  IconData icon;
                  Color color = Colors.white;

                  if (p.precipitation > 70) {
                    icon = Icons.thunderstorm;
                    color = Colors.blue;
                  } else if (p.precipitation > 40) {
                    icon = Icons.cloudy_snowing;
                    color = Colors.blueAccent;
                  } else if (p.isSunny) {
                    icon = Icons.sunny;
                    color = Colors.yellow;
                  } else {
                    icon = Icons.cloud;
                  }

                  return SizedBox(
                    width: itemWidth,
                    child: Center(
                      child: Icon(
                        icon,
                        size: 20,
                        color: color,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              Row(
                children: chartPoints.map((p) {
                  return SizedBox(
                    width: itemWidth,
                    child: Center(
                      child: Text(
                        "${p.temperature.toInt()}°",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 40,
                width: chartPoints.length * itemWidth,
                child: CustomPaint(
                  painter: TemperatureChartPainter(chartPoints),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: chartPoints.map((p) {
                  double topOpacity;

                  if (p.precipitation <= 20) {
                    topOpacity = 0.0;
                  } else if (p.precipitation <= 65) {
                    topOpacity = 0.4;
                  } else {
                    topOpacity = 1.0;
                  }

                  return SizedBox(
                    width: itemWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: Stack(
                            children: [
                              const Icon(
                                Icons.water_drop,
                                size: 16,
                                color: Colors.white,
                              ),
                              if (topOpacity > 0)
                                ClipRect(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    heightFactor: 0.5,
                                    child: Opacity(
                                      opacity: topOpacity,
                                      child: const Icon(
                                        Icons.water_drop,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${p.precipitation.toInt()}%",
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
