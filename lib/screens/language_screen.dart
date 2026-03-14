import 'package:auth_profile_app/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auth_profile_app/providers/languague_provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = context.read<LanguageProvider>();
    final loc = AppLocalizations.of(context);

    String selectedLanguage = languageProvider.locale.languageCode;

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
                    loc?.tr('language') ?? "",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RadioListTile(
                        title: Text(loc.tr('vietnamese')),
                        value: "vi",
                        groupValue: selectedLanguage,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value!;
                          });

                          languageProvider.changeLanguage("vi");
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      RadioListTile(
                        title: Text(loc.tr('english')),
                        value: "en",
                        groupValue: selectedLanguage,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value!;
                          });

                          languageProvider.changeLanguage("en");
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
