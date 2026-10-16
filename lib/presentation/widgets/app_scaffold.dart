import 'package:apache_connect/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:apache_connect/presentation/widgets/app_sidebar.dart';
import 'package:apache_connect/presentation/widgets/employee_watermark.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../routes/app_routes.dart';

import 'app_top_bar.dart';

/// Common shared application layout wrapper for ApacheConnect.
///
/// Desktop/Web:
/// - Persistent Common Sidebar on the left (with logo, nav items, user profile, sign out)
/// - Common AppBar at top (menu toggle, screen title, notification badge 6, theme toggle, profile avatar SI)
/// - Screen-specific content in main canvas
///
/// Mobile (Android/iOS):
/// - Common compact AppBar at top (menu button opening drawer, screen title, notification badge 6, profile avatar SI)
/// - Screen-specific scrollable content in body
/// - Fixed Common Bottom Navigation Bar (Home, Chats, Docs, Alerts, More)
/// - Common Sidebar opens as a Drawer
class AppScaffold extends StatefulWidget {
  final String title;
  final Widget? titleWidget;
  final Widget body;
  final int
      activeNavIndex; // 0 = Dashboard/Home, 1 = Messages/Chats, 2 = Documents/Docs
  final Widget? floatingActionButton;
  final bool isDarkMode;
  final VoidCallback? onThemeToggle;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;
  final VoidCallback? onSignOut;
  final ValueChanged<int>? onNavItemSelected;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final int notificationCount;
  final String employeeName;
  final String employeeNo;

  const AppScaffold({
    super.key,
    required this.title,
    this.titleWidget,
    required this.body,
    required this.activeNavIndex,
    this.floatingActionButton,
    this.isDarkMode = false,
    this.onThemeToggle,
    this.onNotificationPressed,
    this.onProfilePressed,
    this.onSignOut,
    this.onNavItemSelected,
    this.actions,
    this.backgroundColor,
    this.notificationCount = 2,
    this.employeeName = '',
    this.employeeNo = '',
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildWatermarkedBody() {
    final shouldShowWatermark =
        widget.activeNavIndex == 1 || widget.activeNavIndex == 2;

    return Stack(
      fit: StackFit.expand,
      children: [
        widget.body,
        if (shouldShowWatermark)
          Positioned.fill(
            child: EmployeeWatermark(
              employeeName: widget.employeeName,
              employeeNo: widget.employeeNo,
              isDarkMode: widget.isDarkMode,
            ),
          ),
      ],
    );
  }

  // void _handleNavigation(int index) {
  //   if (widget.onNavItemSelected != null) {
  //     widget.onNavItemSelected!(index);
  //     return;
  //   }

  //   if (index == widget.activeNavIndex) return;

  //   switch (index) {
  //     case 0:
  //       Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
  //       break;
  //     case 1:
  //       Navigator.of(context).pushReplacementNamed(AppRoutes.messages);
  //       break;
  //     case 2:
  //       Navigator.of(context).pushReplacementNamed(AppRoutes.documents);
  //       break;
  //     // case 3:
  //     //   ScaffoldMessenger.of(context).showSnackBar(
  //     //     const SnackBar(
  //     //       content: Text('Notifications (398 unread)'),
  //     //       behavior: SnackBarBehavior.floating,
  //     //     ),
  //     //   );
  //     //   break;
  //      case 3:
  //       Navigator.of(context).pushReplacementNamed(AppRoutes.notifications);
  //       break;
  //     case 4:
  //       Navigator.of(context).pushReplacementNamed(AppRoutes.adminDashboard);
  //       break;
  //     default:
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Module will be available in future update'),
  //           behavior: SnackBarBehavior.floating,
  //         ),
  //       );
  //       break;
  //   }
  // }

  void _handleNavigation(int index) {
    // Keep the main application screens inside MainShellScreen.
    // Admin Dashboard must navigate through its named route.
    if (widget.onNavItemSelected != null && index >= 0 && index <= 4) {
      widget.onNavItemSelected!(index);
      return;
    }

    if (index == widget.activeNavIndex) return;

    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
        break;

      case 1:
        Navigator.of(context).pushReplacementNamed(AppRoutes.messages);
        break;

      case 2:
        Navigator.of(context).pushReplacementNamed(AppRoutes.documents);
        break;

      case 3:
        Navigator.of(context).pushReplacementNamed(AppRoutes.notifications);
        break;

      case 4:
        Navigator.of(context).pushReplacementNamed(AppRoutes.adminDashboard);
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Module will be available in future update'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
    }
  }

  void _handleSignOut() {
    if (widget.onSignOut != null) {
      widget.onSignOut!();
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 960;

    final bgColor = widget.backgroundColor ??
        (widget.isDarkMode ? AppColors.dashboardDarkBg : AppColors.dashboardBg);

    if (isMobile) {
      return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: bgColor,
          drawer: Drawer(
            child: AppSidebar(
              selectedIndex: widget.activeNavIndex,
              onItemSelected: (idx) {
                Navigator.of(context).pop();
                _handleNavigation(idx);
              },
              onSignOut: _handleSignOut,
            ),
          ),
          appBar: AppTopBar(
            title: widget.title,
            titleWidget: widget.titleWidget,
            isMobile: true,
            isDarkMode: widget.isDarkMode,
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
            onNotificationPressed: widget.onNotificationPressed,
            onProfilePressed: widget.onProfilePressed,
            actions: widget.actions,
          ),
          // body: widget.body,
          body: _buildWatermarkedBody(),
          bottomNavigationBar: AppBottomNav(
            selectedIndex: widget.activeNavIndex,
            onIndexChanged: (idx) {
              if (idx == 4) {
                _scaffoldKey.currentState?.openDrawer();
              } else {
                _handleNavigation(idx);
              }
            },
            onMorePressed: () => _scaffoldKey.currentState?.openDrawer(),
            isDarkMode: widget.isDarkMode,
          ),
          floatingActionButton: widget.floatingActionButton,
        ),
      );
    }

    // Desktop / Web / macOS / Windows
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgColor,
      body: Row(
        children: [
          // Persistent Sidebar
          AppSidebar(
            selectedIndex: widget.activeNavIndex,
            onItemSelected: _handleNavigation,
            onSignOut: _handleSignOut,
          ),

          // Main Content
          Expanded(
            child: Column(
              children: [
                // Common Top App Bar
                AppTopBar(
                  title: widget.title,
                  titleWidget: widget.titleWidget,
                  isMobile: false,
                  isDarkMode: widget.isDarkMode,
                  onMenuPressed: () {
                    // Desktop toggle
                  },
                  onThemeToggle: widget.onThemeToggle,
                  onNotificationPressed: widget.onNotificationPressed,
                  onProfilePressed: widget.onProfilePressed,
                  actions: widget.actions,
                ),

                // Screen-specific Content Area
                Expanded(
                  // child: widget.body,
                  child: _buildWatermarkedBody(),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
