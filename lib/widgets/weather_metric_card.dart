import 'package:flutter/material.dart';
import './weather_card.dart';

class WeatherMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const WeatherMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  String getNote() {
    double val = double.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

    switch (title.toLowerCase()) {
      case "độ ẩm":
        if (val < 30) return "Không khí khô";
        if (val < 60) return "Độ ẩm dễ chịu";
        return "Độ ẩm đáng chú ý";
      case "gió":
        if (val < 5) return "Gió nhẹ";
        if (val < 10) return "Gió vừa";
        return "Gió mạnh";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      title: title,
      trailing: Icon(icon, size: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getNote(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
