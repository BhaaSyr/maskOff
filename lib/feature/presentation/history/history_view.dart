import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/profile/profile_controller.dart';
import 'package:testvid/feature/controllers/theme_controller.dart';
import 'package:testvid/feature/data/models/history_record_model.dart';
import 'package:testvid/generated/l10n.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
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
                        S.of(context).analysisHistory,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color:
                              isDark ? Colors.white : const Color(0xFF333333),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => controller.refreshHistoryRecords(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withOpacity(0.1)
                                : const Color(0xFF6C63FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.refresh,
                            color: isDark
                                ? Colors.white70
                                : const Color(0xFF6C63FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // History List
                Expanded(
                  child: Obx(() {
                    if (controller.isLoadingHistory.value) {
                      return _buildLoadingState(context, isDark);
                    }

                    if (controller.historyRecords.isEmpty) {
                      return _buildEmptyState(context, isDark);
                    }

                    return _buildHistoryList(context, controller, isDark);
                  }),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildLoadingState(BuildContext context, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              isDark ? Colors.white70 : const Color(0xFF6C63FF),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).loadingHistory,
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white70 : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: isDark ? Colors.white.withOpacity(0.3) : Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).noAnalysisHistoryYet,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white70 : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).analyzeVideoToSeeResults,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white.withOpacity(0.4) : Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(
      BuildContext context, ProfileController controller, bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: controller.historyRecords.length,
      itemBuilder: (context, index) {
        final record = controller.historyRecords[index];
        return _buildHistoryCard(context, controller, record, isDark);
      },
    );
  }

  Widget _buildHistoryCard(BuildContext context, ProfileController controller,
      HistoryRecordModel record, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and delete button
            Row(
              children: [
                Expanded(
                  child: Text(
                    record.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF333333),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showDeleteDialog(context, controller, record),
                  child: Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: isDark
                        ? Colors.white.withOpacity(0.4)
                        : Colors.grey[500],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              record.description,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white60 : Colors.grey[600],
              ),
            ),

            const SizedBox(height: 16),

            // Bottom info
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color:
                      isDark ? Colors.white.withOpacity(0.4) : Colors.grey[500],
                ),
                const SizedBox(width: 4),
                Text(
                  '${record.formattedDate} ${record.formattedTime}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? Colors.white.withOpacity(0.4)
                        : Colors.grey[500],
                  ),
                ),
                const Spacer(),
                if (record.result != null) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getResultColor(record.resultColor, isDark),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      record.result!,
                      style: TextStyle(
                        fontSize: 12,
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
                        fontSize: 12,
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
}
