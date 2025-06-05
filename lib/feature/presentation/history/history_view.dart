import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/profile&history/profile_and_history_controller.dart';
import 'package:testvid/feature/controllers/theme_controller.dart';
import 'package:testvid/feature/data/models/history_record_model.dart';
import 'package:testvid/feature/presentation/history/widgets/history_header.dart';
import 'package:testvid/feature/presentation/history/widgets/history_loading_state.dart';
import 'package:testvid/feature/presentation/history/widgets/history_empty_state.dart';
import 'package:testvid/feature/presentation/history/widgets/history_card.dart';
import 'package:testvid/feature/presentation/history/widgets/history_delete_dialog.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDarkMode;

      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
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
                  HistoryHeader(
                    isDark: isDark,
                    onRefresh: () => controller.refreshHistoryRecords(),
                  ),

                  // History List
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoadingHistory.value) {
                        return HistoryLoadingState(isDark: isDark);
                      }

                      if (controller.historyRecords.isEmpty) {
                        return HistoryEmptyState(isDark: isDark);
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: controller.historyRecords.length,
                        itemBuilder: (context, index) {
                          final record = controller.historyRecords[index];
                          return HistoryCard(
                            record: record,
                            isDark: isDark,
                            onDelete: () => _showDeleteDialog(
                              context,
                              controller,
                              record,
                              isDark,
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _showDeleteDialog(
    BuildContext context,
    ProfileController controller,
    HistoryRecordModel record,
    bool isDark,
  ) {
    showDialog(
      context: context,
      builder: (context) => HistoryDeleteDialog(
        isDark: isDark,
        title: record.title,
        onConfirm: () => controller.deleteHistoryRecord(record.id),
      ),
    );
  }
}
