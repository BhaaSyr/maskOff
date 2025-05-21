import 'dart:async';

import 'package:get/get.dart';
import 'package:testvid/routes/app_pages.dart';

import 'package:http/http.dart' as http;

class SplashController extends GetxController {
  bool isCheckingConnection = true;
  bool hasConnectionError = false;

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
        // İnternet bağlantısı var, 3 saniye bekle ve giriş sayfasına git
        Timer(const Duration(seconds: 3), () {
          Get.offAllNamed(Routes.LOGIN);
        });
      } else {
        // İnternet bağlantısı var ama bir sorun olabilir
        hasConnectionError = true;
      }
    } catch (e) {
      // İstek zaman aşımına uğradı veya başka bir hata oluştu
      hasConnectionError = true;
      print("Bağlantı hatası: $e");
    }

    isCheckingConnection = false;
    update();
  }
}
