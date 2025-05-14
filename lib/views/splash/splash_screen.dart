import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:testvid/controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/logo.png', // Logo dosya yolunu kendi asset yolunuza göre ayarlayın
                  width: 170,
                  height: 170,
                ),
                const SizedBox(height: 20),
                // İnternet kontrolü yapılıyorsa bir yükleme göstergesi
                if (controller.isCheckingConnection)
                  const CircularProgressIndicator(color: Colors.white),
                // İnternet bağlantısı yoksa hata mesajı
                if (controller.hasConnectionError)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          'İnternet bağlantısı yok',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => controller.checkConnection(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, // Buton rengi siyah
                            foregroundColor: Colors.white, // Yazı rengi beyaz
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  12), // Hafif yumuşak köşe
                            ),
                            elevation: 5, // Hafif gölge efekti
                          ),
                          child: const Text(
                            'Tekrar Dene',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
