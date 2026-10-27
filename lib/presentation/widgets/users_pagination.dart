import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class UsersPagination extends StatelessWidget {
  final int startIndex;
  final int endIndex;
  final int totalRecords;
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;
  final bool isDarkMode;

  const UsersPagination({
    super.key,
    required this.startIndex,
    required this.endIndex,
    required this.totalRecords,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Showing 1-7 of 7
          Text(
            totalRecords == 0
                ? 'Showing 0 records'
                : 'Showing $startIndex–$endIndex of $totalRecords',
            style: TextStyle(
              color: isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),

          // Right: < Prev [1] [2] Next >
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Prev Button
              TextButton(
                onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  '‹ Prev',
                  style: TextStyle(
                    color: currentPage > 1
                        ? (isDarkMode ? Colors.white : AppColors.textDark)
                        : (isDarkMode ? const Color(0xFF475569) : const Color(0xFFCBD5E1)),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(width: 4),

              // Page numbers
              ...List.generate(totalPages, (index) {
                final pageNum = index + 1;
                final isSelected = pageNum == currentPage;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: InkWell(
                    onTap: () => onPageChanged(pageNum),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryOrange : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$pageNum',
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : (isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(width: 4),

              // Next Button
              TextButton(
                onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Next ›',
                  style: TextStyle(
                    color: currentPage < totalPages
                        ? (isDarkMode ? Colors.white : AppColors.textDark)
                        : (isDarkMode ? const Color(0xFF475569) : const Color(0xFFCBD5E1)),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
