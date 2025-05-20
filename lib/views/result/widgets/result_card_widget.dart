import 'package:flutter/material.dart';

class ResultCardWidget extends StatelessWidget {
  final bool isDeepfake;
  final double confidenceScore;
  final String resultText;
  final String resultColor;
  final bool isDarkMode;

  const ResultCardWidget({
    Key? key,
    required this.isDeepfake,
    required this.confidenceScore,
    required this.resultText,
    required this.resultColor,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color:
            isDarkMode ? _getBackgroundColorDark() : _getBackgroundColorLight(),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color:
                isDarkMode ? Colors.black.withOpacity(0.3) : _getShadowColor(),
            blurRadius: isDarkMode ? 15 : 20,
            spreadRadius: isDarkMode ? 0 : 1,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.05)
              : Colors.white.withOpacity(0.8),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getIconBackgroundColor(),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIcon(),
                  color: _getIconColor(),
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isDeepfake ? 'Deepfake Detected' : 'Authentic Video',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            isDarkMode ? Colors.white : const Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Confidence Score: ${(confidenceScore * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.7)
                            : const Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              resultText,
              style: TextStyle(
                fontSize: 15,
                color: isDarkMode
                    ? Colors.white.withOpacity(0.9)
                    : const Color(0xFF444444),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Authentic',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDarkMode
                    ? Colors.white.withOpacity(0.8)
                    : const Color(0xFF555555),
              ),
            ),
            Text(
              'Deepfake',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDarkMode
                    ? Colors.white.withOpacity(0.8)
                    : const Color(0xFF555555),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: 10,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: constraints.maxWidth * confidenceScore,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.shade400,
                          Colors.red.shade400,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Color _getBackgroundColorDark() {
    switch (resultColor) {
      case 'high':
        return Colors.red.withOpacity(0.20);
      case 'medium':
        return Colors.orange.withOpacity(0.20);
      case 'low':
        return Colors.green.withOpacity(0.15);
      default:
        return Colors.white.withOpacity(0.08);
    }
  }

  Color _getBackgroundColorLight() {
    return Colors.white;
  }

  Color _getShadowColor() {
    if (isDarkMode) {
      return Colors.black.withOpacity(0.3);
    } else {
      switch (resultColor) {
        case 'high':
          return Colors.red.withOpacity(0.1);
        case 'medium':
          return Colors.orange.withOpacity(0.1);
        case 'low':
          return Colors.green.withOpacity(0.1);
        default:
          return Colors.black.withOpacity(0.05);
      }
    }
  }

  Color _getIconBackgroundColor() {
    if (isDarkMode) {
      switch (resultColor) {
        case 'high':
          return Colors.red.withOpacity(0.2);
        case 'medium':
          return Colors.orange.withOpacity(0.2);
        case 'low':
          return Colors.green.withOpacity(0.2);
        default:
          return Colors.blueGrey.withOpacity(0.2);
      }
    } else {
      switch (resultColor) {
        case 'high':
          return Colors.red.withOpacity(0.1);
        case 'medium':
          return Colors.orange.withOpacity(0.1);
        case 'low':
          return Colors.green.withOpacity(0.1);
        default:
          return const Color(0xFF6C63FF).withOpacity(0.1);
      }
    }
  }

  Color _getIconColor() {
    switch (resultColor) {
      case 'high':
        return Colors.red.shade500;
      case 'medium':
        return Colors.orange.shade500;
      case 'low':
        return Colors.green.shade500;
      default:
        return const Color(0xFF6C63FF);
    }
  }

  IconData _getIcon() {
    switch (resultColor) {
      case 'high':
        return Icons.dangerous;
      case 'medium':
        return Icons.warning;
      case 'low':
        return Icons.check_circle;
      default:
        return Icons.info;
    }
  }
}
