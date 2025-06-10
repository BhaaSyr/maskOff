import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final String currentLanguage;
  final Function(String) onLanguageChanged;
  final bool isDark;

  const LanguageSelector({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildLanguageTile(
            languageCode: 'en',
            languageName: 'English',
            flag: '🇬🇧',
            isSelected: currentLanguage == 'en',
            onTap: () => onLanguageChanged('en'),
            isDark: isDark,
          ),
          Divider(
            color: isDark ? Colors.white24 : Colors.black12,
            height: 1,
          ),
          _buildLanguageTile(
            languageCode: 'tr',
            languageName: 'Türkçe',
            flag: '🇹🇷',
            isSelected: currentLanguage == 'tr',
            onTap: () => onLanguageChanged('tr'),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile({
    required String languageCode,
    required String languageName,
    required String flag,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isSelected
            ? (isDark
                ? const Color(0xFF6C63FF).withValues(alpha: 0.2)
                : const Color(0xFF6C63FF).withValues(alpha: 0.1))
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: isSelected ? 1.1 : 1.0,
                child: Text(flag, style: const TextStyle(fontSize: 22)),
              ),
              const SizedBox(width: 16),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? (isDark ? Colors.white : const Color(0xFF333333))
                      : (isDark ? Colors.white70 : const Color(0xFF666666)),
                ),
                child: Text(languageName),
              ),
              const Spacer(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: isSelected
                    ? const Icon(
                        Icons.check_circle,
                        color: Color(0xFF6C63FF),
                        size: 18,
                        key: ValueKey('selected'),
                      )
                    : const SizedBox(
                        width: 18,
                        height: 18,
                        key: ValueKey('unselected'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
