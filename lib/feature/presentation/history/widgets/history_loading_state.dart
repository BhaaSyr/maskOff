import 'package:flutter/material.dart';
import 'package:testvid/generated/l10n.dart';

class HistoryLoadingState extends StatelessWidget {
  final bool isDark;

  const HistoryLoadingState({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
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
}
