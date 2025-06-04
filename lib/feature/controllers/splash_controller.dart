import 'dart:async';

import 'package:get/get.dart';
import 'package:testvid/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testvid/core/services/app_logger.dart';

import 'package:http/http.dart' as http;

class SplashController extends GetxController {
  bool isCheckingConnection = true;
  bool hasConnectionError = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    checkConnection();
  }

  void checkConnection() async {
    isCheckingConnection = true;
    hasConnectionError = false;
    update();

    try {
      // Gerçek internet bağlantısını test et
      final response = await http
          .get(
            Uri.parse('https://www.google.com'),
          )
          .timeout(const Duration(seconds: 3));

      // Eğer başarılı bir yanıt alırsak (200 OK)
      if (response.statusCode == 200) {
        // İnternet bağlantısı var, 3 saniye bekle ve kullanıcı durumuna göre yönlendir
        Timer(const Duration(seconds: 2), () {
          // Kullanıcı oturum durumunu kontrol et
          if (_auth.currentUser != null) {
            // Kullanıcı giriş yapmış, ana sayfaya yönlendir
            Get.offAllNamed(Routes.home);
          } else {
            // Kullanıcı giriş yapmamış, login sayfasına yönlendir
            Get.offAllNamed(Routes.login);
          }
        });
      } else {
        // İnternet bağlantısı var ama bir sorun olabilir
        hasConnectionError = true;
      }
    } catch (e) {
      AppLogger().error("Bağlantı hatası: $e");
      // İstek zaman aşımına uğradı veya başka bir hata oluştu
      hasConnectionError = true;
    }

    isCheckingConnection = false;
    update();
  }
}
