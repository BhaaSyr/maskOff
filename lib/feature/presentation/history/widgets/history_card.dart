import 'package:flutter/material.dart';
import 'package:testvid/feature/data/models/history_record_model.dart';
import 'package:testvid/generated/l10n.dart';

class HistoryCard extends StatelessWidget {
  final HistoryRecordModel record;
  final bool isDark;
  final VoidCallback onDelete;

  const HistoryCard({
    super.key,
    required this.record,
    required this.isDark,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
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
                  onTap: onDelete,
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
}
