import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/feature/controllers/result_controller.dart';
import 'package:testvid/feature/controllers/theme_controller.dart';
import 'package:testvid/generated/l10n.dart';
import 'widgets/result_card_widget.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
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
            child: Column(
              children: [
                // Header with back button
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
                        S.of(context).analysisResults,
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

                // Results Card or Loading
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Obx(() {
                          if (controller.isAnalyzing.value) {
                            return _buildLoadingWidget(isDark);
                          }

                          if (controller.result.value == null) {
                            return _buildErrorWidget(context, isDark);
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
                  child: _buildButton(
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

  Widget _buildLoadingWidget(bool isDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            isDark ? Colors.white : const Color(0xFF6C63FF),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Analyzing video...',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.white70 : const Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(BuildContext context, bool isDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 48,
          color: isDark ? Colors.white70 : const Color(0xFF666666),
        ),
        const SizedBox(height: 16),
        Text(
          'No analysis results available',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.white70 : const Color(0xFF666666),
          ),
        ),
      ],
    );
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
