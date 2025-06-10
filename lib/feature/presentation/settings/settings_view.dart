import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/language_controller.dart';
import 'package:testvid/feature/controllers/theme_controller.dart';
import 'package:testvid/feature/controllers/auth/auth_controller.dart';
import 'package:testvid/generated/l10n.dart';
import 'widgets/settings_header.dart';
import 'widgets/settings_section_title.dart';
import 'widgets/settings_card.dart';
import 'widgets/settings_switch_tile.dart';
import 'widgets/settings_action_tile.dart';
import 'widgets/settings_info_tile.dart';
import 'widgets/settings_logout_dialog.dart';
import 'widgets/language_selector.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();
    final themeController = Get.find<ThemeController>();
    final authController = Get.find<AuthController>();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button and title
                SettingsHeader(isDark: isDark),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Appearance section
                        SettingsSectionTitle(
                          title: S.of(context).appearance,
                          icon: Icons.color_lens_outlined,
                          isDark: isDark,
                        ),
                        const SizedBox(height: 12),
                        SettingsCard(
                          isDark: isDark,
                          children: [
                            SettingsSwitchTile(
                              icon: Icons.dark_mode_outlined,
                              title: S.of(context).darkMode,
                              value: themeController.isDarkMode,
                              onChanged: (_) => themeController.toggleTheme(),
                              isDark: isDark,
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Profile section
                        SettingsSectionTitle(
                          title: S.of(context).profile,
                          icon: Icons.person_outline,
                          isDark: isDark,
                        ),
                        const SizedBox(height: 12),
                        SettingsCard(
                          isDark: isDark,
                          children: [
                            SettingsActionTile(
                              icon: Icons.edit_outlined,
                              title: 'Manage Profile',
                              onTap: () => Get.toNamed('/profile'),
                              isDark: isDark,
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Language section
                        SettingsSectionTitle(
                          title: S.of(context).language,
                          icon: Icons.language,
                          isDark: isDark,
                        ),
                        const SizedBox(height: 12),
                        SettingsCard(
                          isDark: isDark,
                          children: [
                            LanguageSelector(
                              currentLanguage:
                                  languageController.currentLanguage,
                              onLanguageChanged: (language) =>
                                  languageController.changeLanguage(language),
                              isDark: isDark,
                            ),
                          ],
                        ),

                        // Logout section
                        const SizedBox(height: 24),
                        SettingsSectionTitle(
                          title: S.of(context).logout,
                          icon: Icons.logout,
                          isDark: isDark,
                        ),
                        const SizedBox(height: 12),
                        SettingsCard(
                          isDark: isDark,
                          children: [
                            SettingsActionTile(
                              icon: Icons.logout,
                              title: S.of(context).logout,
                              onTap: () {
                                Get.dialog(
                                  SettingsLogoutDialog(
                                    onConfirm: () => authController.signOut(),
                                    isDark: isDark,
                                  ),
                                );
                              },
                              isDark: isDark,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        SettingsSectionTitle(
                          title: S.of(context).about,
                          icon: Icons.info_outline,
                          isDark: isDark,
                        ),
                        const SizedBox(height: 12),
                        SettingsCard(
                          isDark: isDark,
                          children: [
                            SettingsInfoTile(
                              icon: Icons.verified_outlined,
                              title: 'Mask Off',
                              subtitle: '${S.of(context).version} 1.0.0',
                              isDark: isDark,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
