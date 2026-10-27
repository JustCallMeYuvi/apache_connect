import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class UsersSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final int currentRecords;
  final int totalRecords;
  final bool isDarkMode;

  const UsersSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.currentRecords,
    required this.totalRecords,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isDarkMode ? const Color(0xFF1E293B) : Colors.white;

    final borderColor =
        isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE7E2DC);

    final textColor =
        isDarkMode ? Colors.white : AppColors.textDark;

    final hintColor =
        isDarkMode ? const Color(0xFF64748B) : const Color(0xFF858585);

    final recordColor =
        isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF777783);


  return Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    // Search TextField container
    Expanded(
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            filled: false,
            hintText: 'Search users by any column...',
            hintStyle: TextStyle(
              color: hintColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    tooltip: 'Clear search',
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () {
                      controller.clear();
                      onChanged('');
                    },
                  )
                : null,
          ),
        ),
      ),
    ),

    const SizedBox(width: 12),

    // Separate record-count widget
    Text(
      '$currentRecords of $totalRecords records',
      maxLines: 1,
      softWrap: false,
      style: TextStyle(
        color: recordColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  ],
);
  }
}
