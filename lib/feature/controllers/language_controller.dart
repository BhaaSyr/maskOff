import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  // ignore: constant_identifier_names
  static const String LANGUAGE_CODE_KEY = 'languageCode';

  final RxString _currentLanguage = "en".obs;

  String get currentLanguage => _currentLanguage.value;

  @override
  void onInit() {
    super.onInit();
    _loadLanguageFromPrefs();
  }

  // Load saved language preference
  Future<void> _loadLanguageFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString(LANGUAGE_CODE_KEY);

    if (savedLanguage != null) {
      changeLanguage(savedLanguage);
    }
  }

  // Change language and save preference
  Future<void> changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LANGUAGE_CODE_KEY, languageCode);

    _currentLanguage.value = languageCode;

    // Update locale in GetX
    Get.updateLocale(Locale(languageCode));
  }
}
