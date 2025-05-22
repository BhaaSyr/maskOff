import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/controllers/language_controller.dart';
import 'package:testvid/controllers/theme_controller.dart';
import 'package:testvid/generated/l10n.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();
    final themeController = Get.find<ThemeController>();

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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withOpacity(0.1)
                                : const Color(0xFF6C63FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: isDark
                                ? Colors.white70
                                : const Color(0xFF6C63FF),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        S.of(context).settings,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color:
                              isDark ? Colors.white : const Color(0xFF333333),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Appearance section
                        _buildSectionTitle(context, S.of(context).appearance,
                            Icons.color_lens_outlined, isDark),
                        const SizedBox(height: 12),
                        _buildSettingsCard(
                          context,
                          children: [
                            _buildSwitchTile(
                              icon: Icons.dark_mode_outlined,
                              title: S.of(context).darkMode,
                              value: themeController.isDarkMode,
                              onChanged: (_) => themeController.toggleTheme(),
                              isDark: isDark,
                            ),
                          ],
                          isDark: isDark,
                        ),

                        const SizedBox(height: 24),

                        // Language section
                        _buildSectionTitle(context, S.of(context).language,
                            Icons.language, isDark),
                        const SizedBox(height: 12),
                        _buildSettingsCard(
                          context,
                          isDark: isDark,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  _buildLanguageTile(
                                    languageCode: 'en',
                                    languageName: 'English',
                                    flag: '🇬🇧',
                                    isSelected:
                                        languageController.currentLanguage ==
                                            'en',
                                    onTap: () =>
                                        languageController.changeLanguage('en'),
                                    isDark: isDark,
                                  ),
                                  Divider(
                                    color: isDark
                                        ? Colors.white24
                                        : Colors.black12,
                                    height: 1,
                                  ),
                                  _buildLanguageTile(
                                    languageCode: 'tr',
                                    languageName: 'Türkçe',
                                    flag: '🇹🇷',
                                    isSelected:
                                        languageController.currentLanguage ==
                                            'tr',
                                    onTap: () =>
                                        languageController.changeLanguage('tr'),
                                    isDark: isDark,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // About section
                        _buildSectionTitle(context, S.of(context).about,
                            Icons.info_outline, isDark),
                        const SizedBox(height: 12),
                        _buildSettingsCard(
                          context,
                          isDark: isDark,
                          children: [
                            _buildInfoTile(
                              icon: Icons.verified_outlined,
                              title: 'Mask Off',
                              subtitle: '${S.of(context).version} 1.0.0',
                              isDark: isDark,
                            ),
                            // Divider(
                            //   color: isDark ? Colors.white24 : Colors.black12,
                            //   height: 1,
                            // ),
                            // _buildActionTile(
                            //   icon: Icons.shield_outlined,
                            //   title: S.of(context).privacyPolicy,
                            //   onTap: () {},
                            //   isDark: isDark,
                            // ),
                            // Divider(
                            //   color: isDark ? Colors.white24 : Colors.black12,
                            //   height: 1,
                            // ),
                            // _buildActionTile(
                            //   icon: Icons.description_outlined,
                            //   title: S.of(context).termsOfService,
                            //   onTap: () {},
                            //   isDark: isDark,
                            // ),
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

  Widget _buildSectionTitle(
      BuildContext context, String title, IconData icon, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required List<Widget> children,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.08) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: isDark ? 15 : 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
    required bool isDark,
  }) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : const Color(0xFF6C63FF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
          size: 18,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : const Color(0xFF333333),
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF6C63FF),
        activeTrackColor: const Color(0xFF6C63FF).withOpacity(0.3),
      ),
    );
  }

  Widget _buildLanguageTile({
    required String languageCode,
    required String languageName,
    required String flag,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 16),
            Text(
              languageName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isDark ? Colors.white : const Color(0xFF333333),
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: const Color(0xFF6C63FF),
                size: 18,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDark,
  }) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : const Color(0xFF6C63FF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
          size: 18,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : const Color(0xFF333333),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13,
          color: isDark ? Colors.white60 : Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : const Color(0xFF6C63FF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
            size: 18,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : const Color(0xFF333333),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: isDark ? Colors.white38 : Colors.grey,
        ),
      ),
    );
  }
}
