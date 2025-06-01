import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:testvid/feature/controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1E1E2E),
                  Color(0xFF2D2D44),
                ],
              ),
            ),
            child: Center(
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
                    const CircularProgressIndicator(color: Color(0xFF6C63FF)),
                  // İnternet bağlantısı yoksa hata mesajı
                  if (controller.hasConnectionError)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Text(
                            'İnternet bağlantısı yok',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => controller.checkConnection(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF6C63FF), // Ana tema rengi
                              foregroundColor: Colors.white, // Yazı rengi beyaz
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    16), // Diğer butonlarla uyumlu
                              ),
                              elevation: 3, // Hafif gölge efekti
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
          ),
        );
      },
    );
  }
}
