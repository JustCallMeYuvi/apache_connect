import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';

class DocumentEmptyPreview extends StatelessWidget {
  final bool isDarkMode;

  const DocumentEmptyPreview({
    super.key,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.description_outlined,
            size: 58,
            color: isDarkMode ? const Color(0xFF475569) : const Color(0xFFCBD5E1),
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.selectDocument,
            style: TextStyle(
              color: isDarkMode ? Colors.white : const Color(0xFF334155),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
