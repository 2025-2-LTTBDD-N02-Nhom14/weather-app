import 'package:auth_profile_app/localization/app_localizations.dart';
import 'package:auth_profile_app/providers/languague_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroducerScreen extends StatelessWidget {
  const IntroducerScreen({super.key});

  Widget infoItem(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();

    final loc = AppLocalizations.of(context);

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
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    loc.tr('team_introduction'),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        loc.tr('final_term_project'),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 20),
                    infoItem(
                      loc.tr('subnet'),
                      loc.tr('course'),
                    ),
                    infoItem(
                      loc.tr('project_title'),
                      loc.tr('app_name'),
                    ),
                    infoItem(
                      loc.tr('member'),
                      loc.tr('nguyen_tuan_huy'),
                    ),
                    infoItem(
                      loc.tr('student_id'),
                      loc.tr('23010499'),
                    ),
                    infoItem(
                      loc.tr('team'),
                      loc.tr('14'),
                    ),
                    infoItem(
                      loc.tr('class'),
                      loc.tr('mobile_programming-1-2-25(no2)'),
                    ),
                    infoItem(
                      loc.tr('intructors'),
                      loc.tr('nguyen_xuan_que'),
                    ),
                    infoItem(
                      loc.tr('acadamy_year'),
                      loc.tr('2025-2026'),
                    ),
                    const SizedBox(height: 30),
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
