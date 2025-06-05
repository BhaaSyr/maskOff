import 'package:flutter/material.dart';
import 'package:testvid/generated/l10n.dart';

class HistoryDeleteDialog extends StatelessWidget {
  final bool isDark;
  final String title;
  final VoidCallback onConfirm;

  const HistoryDeleteDialog({
    super.key,
    required this.isDark,
    required this.title,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: isDark ? const Color(0xFF2D2D44) : Colors.white,
      title: Text(
        S.of(context).deleteRecord,
        style: TextStyle(
          color: isDark ? Colors.white : const Color(0xFF333333),
        ),
      ),
      content: Text(
        S.of(context).deleteRecordConfirmation(title),
        style: TextStyle(
          color: isDark ? Colors.white70 : Colors.grey[600],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            S.of(context).cancel,
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.grey[600],
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(
            S.of(context).delete,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
