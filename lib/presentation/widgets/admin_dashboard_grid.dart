import 'package:flutter/material.dart';
import '../../domain/entities/admin_stat_item.dart';
import 'admin_dashboard_card.dart';

/// Responsive Administration Grid
/// Displays 5 columns on desktop/web (matching Screenshot 1),
/// 2-3 columns on tablet, and 1 vertical column on mobile (matching Screenshot 2).
class AdminDashboardGrid extends StatelessWidget {
  final List<AdminStatItem> items;
  final ValueChanged<AdminStatItem> onItemTap;
  final bool isDarkMode;

  const AdminDashboardGrid({
    super.key,
    required this.items,
    required this.onItemTap,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Calculate columns based on width
        int crossAxisCount;
        double childAspectRatio;
        double spacing;

        if (width >= 1200) {
          // Desktop / Web: 5 cards across row 1, 2 cards on row 2
          crossAxisCount = 5;
          childAspectRatio = 1.35;
          spacing = 16.0;
        } else if (width >= 960) {
          // Large tablet / Medium desktop
          crossAxisCount = 4;
          childAspectRatio = 1.35;
          spacing = 16.0;
        } else if (width >= 720) {
          // Standard Tablet
          crossAxisCount = 3;
          childAspectRatio = 1.35;
          spacing = 14.0;
        } else if (width >= 520) {
          // Small Tablet
          crossAxisCount = 2;
          childAspectRatio = 1.4;
          spacing = 14.0;
        } else {
          // Mobile: Single vertical column
          crossAxisCount = 1;
          // childAspectRatio = 2.6;
          // spacing = 14.0;
          childAspectRatio = 2.2;
          spacing = 12.0;
        }

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return AdminDashboardCard(
              item: item,
              isDarkMode: isDarkMode,
              onTap: () => onItemTap(item),
            );
          },
        );
      },
    );
  }
}
