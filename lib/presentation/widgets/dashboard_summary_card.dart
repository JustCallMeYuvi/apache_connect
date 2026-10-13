import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class DashboardSummaryCard extends StatelessWidget {
  final IconData icon;
  final int count;
  final String label;
  final VoidCallback? onTap;
  final bool isDarkMode;

  const DashboardSummaryCard({
    super.key,
    required this.icon,
    required this.count,
    required this.label,
    this.onTap,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDarkMode ? const Color(0x1AFFFFFF) : AppColors.cardBorder,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              // color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.02),
              color: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.02),

              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Peach icon square container
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF332019) : AppColors.peachIconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: AppColors.peachIconColor,
                size: 20,
              ),
            ),

            const SizedBox(width: 16),

            // Number and label
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    count.toString(),
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : AppColors.textDark,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: TextStyle(
                      color: isDarkMode ? const Color(0xFF94A3B8) : AppColors.textGray,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
