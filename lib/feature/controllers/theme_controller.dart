import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testvid/core/services/app_logger.dart';

class ThemeController extends GetxController {
  final _key = 'isDarkMode';
  SharedPreferences? _prefs;

  // Tema durumunu izlemek için Rx
  final RxBool _isDarkMode = true.obs;

  // Tema modu
  Rx<ThemeMode> get themeMode =>
      (_isDarkMode.value ? ThemeMode.dark : ThemeMode.light).obs;

  // Renk şemaları
  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFF1E1E2E),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C63FF),
          secondary: Color(0xFF8A7FFF),
          surface: Color(0xFF1E1E2E),
          onSurface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D2D44),
          elevation: 0,
        ),
        cardColor: const Color(0xFF2D2D44),
        dividerColor: Colors.white10,
      );

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFFF5F5FA),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF6C63FF),
          secondary: Color(0xFF8A7FFF),
          surface: Color(0xFFF5F5FA),
          onSurface: Color(0xFF333333),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(color: Color(0xFF333333)),
          iconTheme: IconThemeData(color: Color(0xFF333333)),
        ),
        cardColor: Colors.white,
        dividerColor: Colors.black12,
      );

  @override
  void onInit() {
    super.onInit();
    AppLogger().info("ThemeController: onInit çağrıldı");
    _initPrefs();
  }

  // SharedPreferences'i başlat
  Future<void> _initPrefs() async {
    try {
      AppLogger().info("ThemeController: SharedPreferences başlatılıyor");
      _prefs = await SharedPreferences.getInstance();
      _loadThemeFromPrefs();
    } catch (e) {
      AppLogger()
          .error("ThemeController: SharedPreferences başlatma hatası: $e");
      // Varsayılan tema kullan
      _isDarkMode.value = true;
    }
  }

  // Temayı SharedPreferences'ten yükle
  void _loadThemeFromPrefs() {
    try {
      if (_prefs != null) {
        final isDark = _prefs!.getBool(_key);
        AppLogger().info("ThemeController: Kaydedilen tema değeri: $isDark");
        if (isDark != null) {
          _isDarkMode.value = isDark;
        } else {
          // Varsayılan koyu tema
          _isDarkMode.value = true;
        }
      } else {
        // SharedPreferences henüz başlatılmadı, varsayılan tema kullan
        _isDarkMode.value = true;
      }
      AppLogger().info(
          "ThemeController: Yüklenen tema: ${_isDarkMode.value ? 'Koyu' : 'Açık'}");
    } catch (e) {
      // Hata durumunda varsayılan koyu tema
      _isDarkMode.value = true;
      AppLogger().error("ThemeController: Tema yükleme hatası: $e");
    }
  }

  // Tema değiştirildiğinde kaydeden metod
  Future<void> _saveThemeToPrefs(bool isDarkMode) async {
    try {
      if (_prefs != null) {
        AppLogger().info(
            "ThemeController: Tema kaydediliyor: ${isDarkMode ? 'Koyu' : 'Açık'}");
        await _prefs!.setBool(_key, isDarkMode);
      }
    } catch (e) {
      AppLogger().error("ThemeController: Tema kaydetme hatası: $e");
    }
  }

  // Tema değiştirme metodu
  void toggleTheme() {
    AppLogger().info("ThemeController: toggleTheme çağrıldı");
    _isDarkMode.value = !_isDarkMode.value;
    AppLogger().info(
        "ThemeController: Tema değiştirildi: ${_isDarkMode.value ? 'Koyu' : 'Açık'}");
    _saveThemeToPrefs(_isDarkMode.value);
    update(); // GetX kontrolcüsünü güncelle
  }

  // Koyu mod mu kontrolü
  bool get isDarkMode => _isDarkMode.value;
}
