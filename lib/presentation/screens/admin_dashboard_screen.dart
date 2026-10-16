import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/entities/admin_stat_item.dart';
import '../bloc/admin/admin_dashboard_bloc.dart';
import '../bloc/admin/admin_dashboard_event.dart';
import '../bloc/admin/admin_dashboard_state.dart';
import '../widgets/admin_dashboard_grid.dart';
import '../widgets/app_scaffold.dart';

/// Complete Admin Dashboard Screen in ApacheConnect following Clean Architecture & BLoC pattern
/// Recreates the Desktop/Web and Mobile layouts from reference screenshots.
class AdminDashboardScreen extends StatefulWidget {
    final ValueChanged<int>? onNavItemSelected;
  const AdminDashboardScreen({super.key, this.onNavItemSelected});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<AdminDashboardBloc>();
    if (bloc.state.status == AdminDashboardStatus.initial) {
      bloc.add(const LoadAdminStatsEvent());
    }
  }

  void _handleCardTap(BuildContext context, AdminStatItem item) {
    context.read<AdminDashboardBloc>().add(SelectAdminItemEvent(item.id));

    // Show informative dialog / bottom sheet regarding the module
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: _isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _isDarkMode
                    ? const Color(0xFF33201B)
                    : AppColors.peachIconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.admin_panel_settings_outlined,
                color: AppColors.primaryOrange,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.displayTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _isDarkMode ? Colors.white : AppColors.textDark,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.description,
              style: TextStyle(
                fontSize: 14,
                color: _isDarkMode ? const Color(0xFFCBD5E1) : AppColors.textGray,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isDarkMode
                    ? const Color(0xFF0F172A)
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _isDarkMode
                      ? const Color(0x1AFFFFFF)
                      : const Color(0xFFE2E8F0),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    size: 18,
                    color: AppColors.primaryOrange,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${item.title} management ${AppStrings.moduleComingSoon}',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: _isDarkMode ? Colors.white70 : AppColors.textDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text(
              'Got it',
              style: TextStyle(
                color: AppColors.primaryOrange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 960;

    return BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
      builder: (context, state) {
        return AppScaffold(
          title: AppStrings.administrationTitle,
          activeNavIndex: 4, // 4 = Admin dashboard in sidebar
           onNavItemSelected: widget.onNavItemSelected, // ADD THIS LINE
          isDarkMode: _isDarkMode,
          notificationCount: isMobile ? 37 : 36,
          backgroundColor:
              _isDarkMode ? AppColors.dashboardDarkBg : const Color(0xFFF7F5F0),
          onThemeToggle: () {
            setState(() => _isDarkMode = !_isDarkMode);
          },
          onNotificationPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'You have ${isMobile ? 37 : 36} unread administrative alerts',
                ),
                backgroundColor: AppColors.primaryOrange,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          onProfilePressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Logged in as Syed Imran (Admin)'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          body: RefreshIndicator(
            color: AppColors.primaryOrange,
            onRefresh: () async {
              context
                  .read<AdminDashboardBloc>()
                  .add(const RefreshAdminStatsEvent());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 32,
                vertical: isMobile ? 20 : 28,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Heading: "Admin dashboard" matching Screenshots 1 & 2
                  Text(
                    AppStrings.adminDashboardHeading,
                    style: TextStyle(
                      color: _isDarkMode ? Colors.white : AppColors.textDark,
                      fontSize: isMobile ? 22 : 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                    ),
                  ),

                  SizedBox(height: isMobile ? 18 : 24),

                  // Cards Content View
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 60),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryOrange,
                        ),
                      ),
                    )
                  else if (state.isFailure)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.error_outline_rounded,
                              size: 40,
                              color: AppColors.error,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              state.errorMessage ??
                                  'Failed to load admin dashboard',
                              style: const TextStyle(
                                color: AppColors.textGray,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<AdminDashboardBloc>()
                                    .add(const LoadAdminStatsEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryOrange,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    AdminDashboardGrid(
                      items: state.items,
                      isDarkMode: _isDarkMode,
                      onItemTap: (item) => _handleCardTap(context, item),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
