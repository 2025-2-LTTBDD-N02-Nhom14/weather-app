import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auth_profile_app/screens/language_screen.dart';
import 'package:auth_profile_app/screens/introducer_screen.dart';
import 'package:auth_profile_app/providers/languague_provider.dart';
import 'package:auth_profile_app/localization/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  Widget buildCard({
    required BuildContext context,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return Container(
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
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF1976D2),
                    fontSize: 13,
                  ),
                )
              : null,
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();

    final loc = AppLocalizations.of(context);

    String currentLanguage =
        languageProvider.locale.languageCode == "vi" ? "Tiếng Việt" : "English";

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 26),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 6),
                  Text(
                    loc?.tr('weather_setting') ?? "",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    buildCard(
                      context: context,
                      title: loc?.tr('language') ?? "",
                      subtitle: currentLanguage,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LanguageScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    buildCard(
                      context: context,
                      title: loc?.tr('team_introduction') ?? "",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const IntroducerScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
