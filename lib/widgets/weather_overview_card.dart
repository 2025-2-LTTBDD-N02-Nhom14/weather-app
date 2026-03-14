import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auth_profile_app/providers/languague_provider.dart';
import 'package:auth_profile_app/localization/app_localizations.dart';

class WeatherOverviewCard extends StatelessWidget {
  final String temperature;
  final String description;
  final String maxTemp;
  final String minTemp;
  final String feelsLike;

  const WeatherOverviewCard({
    super.key,
    required this.temperature,
    required this.description,
    required this.maxTemp,
    required this.minTemp,
    required this.feelsLike,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();

    final loc = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
        bottom: 60,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              temperature,
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.w100,
                color: Colors.white,
                height: 1,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_upward, size: 16, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  maxTemp,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 8),
                const Text("/", style: TextStyle(color: Colors.white)),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_downward, size: 16, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  minTemp,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              loc.tr('feelLikes') + "$feelsLike",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
