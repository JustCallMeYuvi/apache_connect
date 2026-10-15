import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/admin_stat_item.dart';

/// Reusable Administration Dashboard Card widget
/// Displays orange line icon in peach container, title with count, and "Manage" subtitle.
class AdminDashboardCard extends StatefulWidget {
  final AdminStatItem item;
  final VoidCallback onTap;
  final bool isDarkMode;

  const AdminDashboardCard({
    super.key,
    required this.item,
    required this.onTap,
    this.isDarkMode = false,
  });

  @override
  State<AdminDashboardCard> createState() => _AdminDashboardCardState();
}

class _AdminDashboardCardState extends State<AdminDashboardCard> {
  bool _isHovered = false;

  IconData _getIcon(AdminIconType iconType) {
    switch (iconType) {
      case AdminIconType.users:
        return Icons.people_outline_rounded;
      case AdminIconType.roles:
        return Icons.shield_outlined;
      case AdminIconType.factories:
        return Icons.apartment_rounded;
      case AdminIconType.locations:
        return Icons.location_on_outlined;
      case AdminIconType.categories:
        return Icons.format_list_bulleted_rounded;
      case AdminIconType.settings:
        return Icons.tune_rounded;
      case AdminIconType.auditLog:
        return Icons.access_time_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final item = widget.item;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                // ? AppColors.primaryOrange.withOpacity(0.5)
                ? AppColors.primaryOrange.withValues(alpha: 0.5)

                : (isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0)),
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  // ? AppColors.primaryOrange.withOpacity(0.08)
                  ? AppColors.primaryOrange.withValues(alpha: 0.08)

                  : (isDark
                      ? Colors.black.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.02)),
              blurRadius: _isHovered ? 12 : 6,
              offset: Offset(0, _isHovered ? 4 : 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon box with peach background and orange line icon
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF33201B)
                          : AppColors.peachIconBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      _getIcon(item.iconType),
                      color: AppColors.primaryOrange,
                      size: 24,
                    ),
                  ),

                  const SizedBox(height: 08),

                  // Title and Subtitle group
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.displayTitle,
                        style: TextStyle(
                          color: isDark ? Colors.white : AppColors.textDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          color: isDark
                              ? const Color(0xFF94A3B8)
                              : AppColors.textGray,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
