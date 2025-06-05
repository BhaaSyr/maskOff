import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsLanguageTile extends StatelessWidget {
  final String currentLanguage;
  final Function(String) onLanguageChanged;
  final bool isDark;

  const SettingsLanguageTile({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : const Color(0xFF6C63FF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.language,
          color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
          size: 18,
        ),
      ),
      title: Text(
        'Language',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : const Color(0xFF333333),
        ),
      ),
      trailing: DropdownButton<String>(
        value: currentLanguage,
        underline: const SizedBox(),
        icon: Icon(
          Icons.arrow_drop_down,
          color: isDark ? Colors.white70 : const Color(0xFF6C63FF),
        ),
        style: TextStyle(
          color: isDark ? Colors.white : const Color(0xFF333333),
          fontSize: 15,
        ),
        onChanged: (String? newValue) {
          if (newValue != null) {
            onLanguageChanged(newValue);
          }
        },
        items: <String>['English', 'Spanish', 'French', 'German']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
