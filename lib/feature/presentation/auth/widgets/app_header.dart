import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/language_controller.dart';
import 'package:testvid/feature/controllers/theme_controller.dart';

class AppHeader extends StatelessWidget {
  final bool isDark;
  final bool showBackButton;
  final String? title;
  final VoidCallback? onBackPressed;

  const AppHeader({
    super.key,
    required this.isDark,
    this.showBackButton = false,
    this.title,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final languageController = Get.find<LanguageController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (showBackButton)
          GestureDetector(
            onTap: onBackPressed ?? () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : const Color(0xFF6C63FF).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
              ),
            ),
          )
        else
          const SizedBox.shrink(),
        const SizedBox.shrink(),
        Row(
          children: [
            // Language toggle
            GestureDetector(
              onTap: () =>
                  _showLanguagePickerDialog(isDark, languageController),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : const Color(0xFF6C63FF).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.language,
                  color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Theme toggle
            GestureDetector(
              onTap: () => themeController.toggleTheme(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : const Color(0xFF6C63FF).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode,
                  color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showLanguagePickerDialog(bool isDark, LanguageController controller) {
    Get.dialog(
      SimpleDialog(
        backgroundColor: isDark ? const Color(0xFF2D2D44) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // English option
          InkWell(
            onTap: () {
              controller.changeLanguage('en');
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🇬🇧', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 12),
                  Text(
                    'English',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white : const Color(0xFF333333),
                      fontWeight: controller.currentLanguage == 'en'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  const Spacer(),
                  if (controller.currentLanguage == 'en')
                    const Icon(
                      Icons.check,
                      size: 16,
                      color: Color(0xFF6C63FF),
                    ),
                ],
              ),
            ),
          ),
          Divider(
              height: 1,
              thickness: 1,
              color: isDark ? Colors.white12 : Colors.black12),
          // Turkish option
          InkWell(
            onTap: () {
              controller.changeLanguage('tr');
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🇹🇷', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 12),
                  Text(
                    'Türkçe',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white : const Color(0xFF333333),
                      fontWeight: controller.currentLanguage == 'tr'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  const Spacer(),
                  if (controller.currentLanguage == 'tr')
                    const Icon(
                      Icons.check,
                      size: 16,
                      color: Color(0xFF6C63FF),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      barrierColor: Colors.black54,
    );
  }
}
