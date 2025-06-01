import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/profile/profile_controller.dart';
import 'package:testvid/feature/controllers/theme_controller.dart';
import 'package:testvid/feature/data/models/history_record_model.dart';
import 'package:testvid/generated/l10n.dart';

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
                ? _buildLoadingState(isDark)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with back button and title
                      _buildHeader(context, isDark),

                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Profile Avatar Section (centered, no card)
                              Center(
                                child: _buildCenteredAvatar(
                                    context, controller, isDark),
                              ),

                              const SizedBox(height: 30),

                              // Personal Information section
                              _buildSectionTitle(
                                  context,
                                  S.of(context).personalInformation,
                                  Icons.person_outline,
                                  isDark),
                              const SizedBox(height: 12),
                              _buildPersonalInfoCard(
                                  context, controller, isDark),

                              const SizedBox(height: 24),

                              // History Records section
                              _buildSectionTitle(
                                  context,
                                  S.of(context).analysisHistory,
                                  Icons.history,
                                  isDark),
                              const SizedBox(height: 12),
                              _buildHistoryButton(context, isDark),
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

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
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
                color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            S.of(context).profile,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenteredAvatar(
      BuildContext context, ProfileController controller, bool isDark) {
    return Column(
      children: [
        // Profile Avatar
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6C63FF),
                Color(0xFF9C93FF),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.person,
            color: Colors.white,
            size: 40,
          ),
        ),

        const SizedBox(height: 15),

        // User Info
        Obx(() {
          final user = controller.userModel.value;
          final hasName = user?.firstName != null && user?.lastName != null;

          return Column(
            children: [
              if (hasName) ...[
                Text(
                  user!.fullName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF333333),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
              ],
              Text(
                user?.email ?? '',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white60 : Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildPersonalInfoCard(
      BuildContext context, ProfileController controller, bool isDark) {
    return _buildSettingsCard(
      context,
      isDark: isDark,
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              // First Name Field
              _buildInputField(
                context: context,
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
              _buildInputField(
                context: context,
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
              _buildInputField(
                context: context,
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
              _buildSaveButton(context, controller, isDark),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required RxString errorObservable,
    required TextInputType keyboardType,
    required TextInputAction textInputAction,
    required bool isDark,
  }) {
    return Obx(() {
      final errorText = errorObservable.value;
      final hasError = errorText.isNotEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 5),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: hasError
                      ? Colors.red
                      : isDark
                          ? Colors.white70
                          : const Color(0xFF6C63FF),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: hasError
                        ? Colors.red
                        : isDark
                            ? Colors.white70
                            : const Color(0xFF6C63FF),
                  ),
                ),
              ],
            ),
          ),

          // Input Field
          Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasError
                    ? Colors.red
                    : isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.grey[300]!,
              ),
            ),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              style: TextStyle(
                color: isDark ? Colors.white : const Color(0xFF333333),
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: isDark ? Colors.white38 : Colors.grey[500],
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
              ),
            ),
          ),

          // Error Text
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 4),
              child: Text(
                errorText,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildSaveButton(
      BuildContext context, ProfileController controller, bool isDark) {
    return Obx(() {
      final isSaving = controller.isSaving.value;

      return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: isSaving ? null : () => controller.saveProfile(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBackgroundColor: Colors.grey[400],
          ),
          child: isSaving
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Saving...',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.save_outlined, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      S.of(context).save,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
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

  Widget _buildLoadingState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6C63FF).withOpacity(0.3),
                  const Color(0xFF9C93FF).withOpacity(0.3),
                ],
              ),
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                isDark ? Colors.white70 : const Color(0xFF6C63FF),
              ),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Loading your profile...',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white70 : Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // History Section Methods

  Widget _buildHistorySection(
      BuildContext context, ProfileController controller, bool isDark) {
    return _buildSettingsCard(
      context,
      isDark: isDark,
      children: [
        // History Header with refresh button
        _buildHistoryHeader(context, controller, isDark),

        // History Content
        Obx(() {
          if (controller.isLoadingHistory.value) {
            return _buildHistoryLoadingState(context, isDark);
          }

          if (controller.historyRecords.isEmpty) {
            return _buildEmptyHistoryState(context, isDark);
          }

          return _buildHistoryList(
              context, controller, controller.historyRecords, isDark);
        }),
      ],
    );
  }

  Widget _buildHistoryHeader(
      BuildContext context, ProfileController controller, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              S.of(context).analysisHistory,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : const Color(0xFF333333),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => controller.refreshHistoryRecords(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : const Color(0xFF6C63FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.refresh,
                size: 18,
                color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryLoadingState(BuildContext context, bool isDark) {
    return Container(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                isDark ? Colors.white70 : const Color(0xFF6C63FF),
              ),
              strokeWidth: 2,
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).loadingHistory,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white60 : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyHistoryState(BuildContext context, bool isDark) {
    return Container(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 48,
              color: isDark ? Colors.white.withOpacity(0.3) : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).noAnalysisHistoryYet,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white60 : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).analyzeVideoToSeeResults,
              style: TextStyle(
                fontSize: 12,
                color:
                    isDark ? Colors.white.withOpacity(0.4) : Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context, ProfileController controller,
      List<HistoryRecordModel> records, bool isDark) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: records.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final record = records[index];
        return _buildHistoryRecordCard(context, controller, record, isDark);
      },
    );
  }

  Widget _buildHistoryRecordCard(BuildContext context,
      ProfileController controller, HistoryRecordModel record, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[200]!,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and status
            Row(
              children: [
                Expanded(
                  child: Text(
                    record.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF333333),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showDeleteDialog(context, controller, record),
                  child: Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: isDark
                        ? Colors.white.withOpacity(0.4)
                        : Colors.grey[500],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Description
            Text(
              record.description,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white60 : Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // Bottom info
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 12,
                  color:
                      isDark ? Colors.white.withOpacity(0.4) : Colors.grey[500],
                ),
                const SizedBox(width: 4),
                Text(
                  '${record.formattedDate} ${record.formattedTime}',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark
                        ? Colors.white.withOpacity(0.4)
                        : Colors.grey[500],
                  ),
                ),
                const Spacer(),
                if (record.result != null) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getResultColor(record.resultColor, isDark),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      record.result!,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getResultTextColor(record.resultColor),
                      ),
                    ),
                  ),
                  if (record.confidence != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      record.formattedConfidence,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color:
                            isDark ? Colors.white70 : const Color(0xFF6C63FF),
                      ),
                    ),
                  ],
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getResultColor(String resultType, bool isDark) {
    switch (resultType) {
      case 'real':
        return Colors.green.withOpacity(isDark ? 0.3 : 0.1);
      case 'fake':
        return Colors.red.withOpacity(isDark ? 0.3 : 0.1);
      default:
        return Colors.grey.withOpacity(isDark ? 0.3 : 0.1);
    }
  }

  Color _getResultTextColor(String resultType) {
    switch (resultType) {
      case 'real':
        return Colors.green;
      case 'fake':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showDeleteDialog(BuildContext context, ProfileController controller,
      HistoryRecordModel record) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Get.find<ThemeController>().isDarkMode
            ? const Color(0xFF2D2D44)
            : Colors.white,
        title: Text(
          S.of(context).deleteRecord,
          style: TextStyle(
            color: Get.find<ThemeController>().isDarkMode
                ? Colors.white
                : const Color(0xFF333333),
          ),
        ),
        content: Text(
          S.of(context).deleteRecordConfirmation(record.title),
          style: TextStyle(
            color: Get.find<ThemeController>().isDarkMode
                ? Colors.white70
                : Colors.grey[600],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              S.of(context).cancel,
              style: TextStyle(
                color: Get.find<ThemeController>().isDarkMode
                    ? Colors.white70
                    : Colors.grey[600],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteHistoryRecord(record.id);
            },
            child: Text(
              S.of(context).delete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryButton(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => Get.toNamed('/history'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.history, size: 20),
        label: Text(
          S.of(context).viewFullHistory,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
