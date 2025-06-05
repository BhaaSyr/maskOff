import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/profile&history/profile_and_history_controller.dart';
import 'package:testvid/feature/controllers/theme_controller.dart';
import 'package:testvid/generated/l10n.dart';
import 'widgets/profile_avatar.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_history_button.dart';
import 'widgets/profile_loading_state.dart';
import 'widgets/profile_personal_info.dart';
import 'widgets/profile_section_title.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    final ThemeController themeController = Get.find<ThemeController>();

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
            child: Obx(() => controller.isLoading.value
                ? ProfileLoadingState(isDark: isDark)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with back button and title
                      ProfileHeader(isDark: isDark),

                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Profile Avatar Section (centered, no card)
                              Center(
                                child: ProfileAvatar(
                                  controller: controller,
                                  isDark: isDark,
                                ),
                              ),

                              const SizedBox(height: 30),

                              // Personal Information section
                              ProfileSectionTitle(
                                title: S.of(context).personalInformation,
                                icon: Icons.person_outline,
                                isDark: isDark,
                              ),
                              const SizedBox(height: 12),
                              ProfilePersonalInfo(
                                controller: controller,
                                isDark: isDark,
                              ),

                              const SizedBox(height: 24),

                              // History Records section
                              ProfileSectionTitle(
                                title: S.of(context).analysisHistory,
                                icon: Icons.history,
                                isDark: isDark,
                              ),
                              const SizedBox(height: 12),
                              ProfileHistoryButton(isDark: isDark),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
          ),
        ),
      );
    });
  }
}
