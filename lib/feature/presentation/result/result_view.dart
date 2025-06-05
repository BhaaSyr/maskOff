import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/result_controller.dart';
import 'package:testvid/feature/controllers/theme_controller.dart';
import 'package:testvid/generated/l10n.dart';
import 'widgets/result_action_button.dart';
import 'widgets/result_card_widget.dart';
import 'widgets/result_error_widget.dart';
import 'widgets/result_header.dart';
import 'widgets/result_loading_widget.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
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
              children: [
                // Header with back button
                ResultHeader(isDark: isDark),

                // Results Card or Loading
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Obx(() {
                          if (controller.isAnalyzing.value) {
                            return ResultLoadingWidget(isDark: isDark);
                          }

                          if (controller.result.value == null) {
                            return ResultErrorWidget(isDark: isDark);
                          }

                          return ResultCardWidget(
                            isDeepfake: controller.result.value!.isDeepfake,
                            confidenceScore:
                                controller.result.value!.confidence,
                            resultText: _getLocalizedResultText(context),
                            resultColor: controller.getResultColor(),
                            isDarkMode: isDark,
                          );
                        }),
                      ),
                    ),
                  ),
                ),

                // Bottom action button
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ResultActionButton(
                    icon: Icons.home,
                    label: S.of(context).backToHomepage,
                    onPressed: () => Get.offNamed("/home"),
                    isPrimary: false,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  String _getLocalizedResultText(BuildContext context) {
    if (controller.result.value == null) {
      return '';
    }

    final score = controller.result.value!.confidence.toStringAsFixed(1);

    if (controller.result.value!.isDeepfake) {
      return S.of(context).deepfakeResult(score);
    } else {
      return S.of(context).realVideoResult(score);
    }
  }
}
