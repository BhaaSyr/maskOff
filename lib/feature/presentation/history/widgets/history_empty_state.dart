import 'package:flutter/material.dart';
import 'package:testvid/generated/l10n.dart';

class HistoryEmptyState extends StatelessWidget {
  final bool isDark;

  const HistoryEmptyState({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color:
                isDark ? Colors.white.withValues(alpha: 0.3) : Colors.grey[400],
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
              color: isDark
                  ? Colors.white.withValues(alpha: 0.4)
                  : Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
