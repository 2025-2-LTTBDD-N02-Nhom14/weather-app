import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends ChangeNotifier {
  static const String keyLanguage = 'language_code';

  Locale _locale = const Locale('vi');
  Locale get locale => _locale;

  LanguageService() {
    _loadLanguage();
  }

  Future<void> changeLanguage(String languageCode) async {
    _locale = Locale(languageCode);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyLanguage, languageCode);
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString(keyLanguage);

    if (savedLang != null) {
      _locale = Locale(savedLang);
      notifyListeners();
    }
  }
}