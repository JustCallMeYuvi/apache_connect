import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/entities/chat_conversation.dart';

class ChatFilterTabs extends StatelessWidget {
  final ChatFilterType selectedFilter;
  final ValueChanged<ChatFilterType> onFilterChanged;
  final bool isDarkMode;

  const ChatFilterTabs({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.all(3.5),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTab(
            label: AppStrings.filterAll,
            filter: ChatFilterType.all,
          ),
          _buildTab(
            label: AppStrings.filterDirect,
            filter: ChatFilterType.direct,
          ),
          _buildTab(
            label: AppStrings.filterGroups,
            filter: ChatFilterType.groups,
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required ChatFilterType filter,
  }) {
    final isSelected = selectedFilter == filter;

    return Expanded(
      child: InkWell(
        onTap: () => onFilterChanged(filter),
        borderRadius: BorderRadius.circular(9),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? (isDarkMode ? const Color(0xFF334155) : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      // color: Colors.black.withOpacity(0.04),
                      color: Colors.black.withValues(alpha: 0.04),

                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? AppColors.primaryOrange
                  : (isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
              fontSize: 13.5,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
