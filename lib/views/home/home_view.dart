import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/controllers/home_controller.dart';
import 'package:testvid/controllers/theme_controller.dart';
import 'package:testvid/views/home/widgets/video_player_widget.dart';
import 'package:testvid/controllers/auth/auth_controller.dart';
import 'package:testvid/routes/app_pages.dart';
import 'package:testvid/generated/l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final VideoController controller = Get.put(VideoController());
    final ThemeController themeController = Get.find<ThemeController>();
    final AuthController authController = Get.find<AuthController>();
    final screenSize = MediaQuery.of(context).size;

    return Obx(() {
      final isDark = themeController.isDarkMode;

      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      const Color(0xFF1E1E2E),
                      const Color(0xFF2D2D44),
                    ]
                  : [
                      const Color(0xFFF5F5FA),
                      const Color(0xFFE8E8F0),
                    ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).appTitle,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color:
                              isDark ? Colors.white : const Color(0xFF333333),
                          letterSpacing: 0.5,
                        ),
                      ),
                      Row(
                        children: [
                          // Çıkış butonu
                          GestureDetector(
                            onTap: () {
                              Get.dialog(
                                AlertDialog(
                                  title: Text(
                                    S.of(context).logout,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                  content: Text(
                                    S.of(context).logoutConfirmation,
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                  ),
                                  backgroundColor: isDark
                                      ? const Color(0xFF2D2D44)
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text(
                                        S.of(context).cancel,
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black54,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                        authController.signOut();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF6C63FF),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                      ),
                                      child: Text(S.of(context).logout),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withOpacity(0.1)
                                    : const Color(0xFF6C63FF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.logout,
                                color: isDark
                                    ? Colors.white70
                                    : const Color(0xFF6C63FF),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Tema değiştirme butonu
                          GestureDetector(
                            onTap: () {
                              print("Tema değiştirme butonu tıklandı");
                              print("Mevcut tema: ${isDark ? 'Koyu' : 'Açık'}");
                              themeController.toggleTheme();
                              print(
                                  "Yeni tema: ${themeController.isDarkMode ? 'Koyu' : 'Açık'}");
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withOpacity(0.1)
                                    : const Color(0xFF6C63FF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                isDark ? Icons.light_mode : Icons.dark_mode,
                                color: isDark
                                    ? Colors.white70
                                    : const Color(0xFF6C63FF),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Bilgi butonu

                          // Settings button
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.SETTINGS),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withOpacity(0.1)
                                    : const Color(0xFF6C63FF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.settings,
                                color: isDark
                                    ? Colors.white70
                                    : const Color(0xFF6C63FF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(
                    S.of(context).detectDeepfake,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? Colors.white.withOpacity(0.7)
                          : const Color(0xFF555555),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Video Display Area
                  Expanded(
                    child: Center(
                      child: Obx(() {
                        if (controller.playerController.value != null &&
                            controller.isInitialized.value) {
                          return _buildVideoCard(controller, isDark);
                        } else {
                          return _buildEmptyState(isDark);
                        }
                      }),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildButton(
                          icon: Icons.file_upload_outlined,
                          label: S.of(context).uploadVideo,
                          onPressed: controller.pickVideo,
                          isPrimary: true,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildButton(
                          icon: Icons.search,
                          label: S.of(context).analyze,
                          onPressed: () {
                            if (controller.isInitialized.value) {
                              Get.toNamed("/result");
                            } else {
                              Get.snackbar(
                                S.of(context).uploadRequired,
                                S.of(context).pleaseUploadFirst,
                                backgroundColor: isDark
                                    ? Colors.white
                                    : const Color(0xFF333333),
                                colorText: isDark ? Colors.black : Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                                margin: const EdgeInsets.all(20),
                                borderRadius: 10,
                              );
                            }
                          },
                          isPrimary: false,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildVideoCard(VideoController controller, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.08) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.videocam,
                    color: Color(0xFF6C63FF),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  S.current.yourVideo,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF333333),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    controller.clearVideo();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.1)
                          : const Color(0xFFEEEEF6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.close,
                      color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: VideoPlayerWidget(
              controller: controller.playerController.value!,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.08) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color:
              isDark ? Colors.white.withOpacity(0.1) : const Color(0xFFEEEEF6),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add_photo_alternate_outlined,
              size: 40,
              color: Color(0xFF6C63FF),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            S.current.uploadToBegin,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            S.current.tapUploadButton,
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? Colors.white.withOpacity(0.6)
                  : const Color(0xFF777777),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required bool isPrimary,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isPrimary
                ? const Color(0xFF6C63FF).withOpacity(0.3)
                : Colors.black.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? const Color(0xFF6C63FF)
              : (isDark ? Colors.white.withOpacity(0.08) : Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(
                    color: isDark
                        ? Colors.white.withOpacity(0.1)
                        : const Color(0xFFEEEEF6),
                    width: 1,
                  ),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isPrimary ? Colors.white : const Color(0xFF6C63FF),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isPrimary ? Colors.white : const Color(0xFF6C63FF),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
