import 'package:flutter/material.dart';
import 'package:testvid/feature/controllers/profile&history/profile_and_history_controller.dart';
import 'package:testvid/generated/l10n.dart';
import 'profile_input_field.dart';
import 'profile_save_button.dart';
import 'profile_settings_card.dart';

class ProfilePersonalInfo extends StatelessWidget {
  final ProfileController controller;
  final bool isDark;

  const ProfilePersonalInfo({
    super.key,
    required this.controller,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileSettingsCard(
      isDark: isDark,
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              // First Name Field
              ProfileInputField(
                controller: controller.firstNameController,
                label: S.of(context).firstName,
                hint: S.of(context).firstNameHint,
                icon: Icons.person_outline,
                errorObservable: controller.firstNameError,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                isDark: isDark,
              ),

              const SizedBox(height: 15),

              // Last Name Field
              ProfileInputField(
                controller: controller.lastNameController,
                label: S.of(context).lastName,
                hint: S.of(context).lastNameHint,
                icon: Icons.badge_outlined,
                errorObservable: controller.lastNameError,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                isDark: isDark,
              ),

              const SizedBox(height: 15),

              // Age Field
              ProfileInputField(
                controller: controller.ageController,
                label: S.of(context).age,
                hint: S.of(context).ageHint,
                icon: Icons.cake_outlined,
                errorObservable: controller.ageError,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                isDark: isDark,
              ),

              const SizedBox(height: 20),

              // Save Button
              ProfileSaveButton(
                controller: controller,
                isDark: isDark,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
