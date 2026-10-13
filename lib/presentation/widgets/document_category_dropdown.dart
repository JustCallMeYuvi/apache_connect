import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class DocumentCategoryDropdown extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;
  final bool isDarkMode;

  const DocumentCategoryDropdown({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: categories.contains(selectedCategory) ? selectedCategory : categories.first,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: isDarkMode ? const Color(0xFF94A3B8) : AppColors.textDark,
            size: 22,
          ),
          dropdownColor: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          style: TextStyle(
            color: isDarkMode ? Colors.white : AppColors.textDark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          items: categories.map((cat) {
            return DropdownMenuItem<String>(
              value: cat,
              child: Text(cat),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              onCategoryChanged(val);
            }
          },
        ),
      ),
    );
  }
}
