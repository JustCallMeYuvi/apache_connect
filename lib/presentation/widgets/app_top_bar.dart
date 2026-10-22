// import 'package:flutter/material.dart';
// import '../../core/constants/app_colors.dart';
// import '../../core/constants/app_strings.dart';

// /// Reusable Common Top AppBar across Dashboard, Messages, and Documents.
// /// Supports both Desktop/Web and Mobile compact layouts.
// class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final Widget? titleWidget;
//   final bool isMobile;
//   final VoidCallback? onMenuPressed;
//   final VoidCallback? onNotificationPressed;
//   final VoidCallback? onThemeToggle;
//   final VoidCallback? onProfilePressed;
//   final bool isDarkMode;
//   final int notificationCount;
//   final String userInitials;
//   final List<Widget>? actions;

//   const AppTopBar({
//     super.key,
//     this.title = AppStrings.dashboardTitle,
//     this.titleWidget,
//     required this.isMobile,
//     this.onMenuPressed,
//     this.onNotificationPressed,
//     this.onThemeToggle,
//     this.onProfilePressed,
//     this.isDarkMode = false,
//     this.notificationCount = 6,
//     this.userInitials = 'Yuvi',
//     this.actions,

//   });

//   @override
//   Size get preferredSize => const Size.fromHeight(60);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
//       decoration: BoxDecoration(
//         color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
//         border: Border(
//           bottom: BorderSide(
//             color: isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(
//         children: [
//           // Left: Menu / Sidebar toggle icon
//           IconButton(
//             onPressed: onMenuPressed ??
//                 () {
//                   if (isMobile) {
//                     Scaffold.maybeOf(context)?.openDrawer();
//                   }
//                 },
//             icon: Icon(
//               isMobile ? Icons.menu_rounded : Icons.view_sidebar_outlined,
//               color: isDarkMode ? Colors.white : AppColors.textDark,
//               size: 22,
//             ),
//             tooltip: isMobile ? 'Open Menu' : 'Toggle Sidebar',
//             padding: EdgeInsets.zero,
//             constraints: const BoxConstraints(),
//           ),

//           const SizedBox(width: 16),

//           // Title
//           titleWidget ??
//               Text(
//                 title,
//                 style: TextStyle(
//                   color: isDarkMode ? Colors.white : AppColors.textDark,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   letterSpacing: -0.2,
//                 ),
//               ),

//           const Spacer(),

//           if (actions != null) ...actions!,

//           // Right: Notification Bell with Badge 6
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               IconButton(
//                 onPressed: onNotificationPressed ??
//                     () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Notifications ($notificationCount unread)'),
//                           behavior: SnackBarBehavior.floating,
//                           backgroundColor:
//                               isDarkMode ? const Color(0xFF334155) : const Color(0xFF1E293B),
//                         ),
//                       );
//                     },
//                 icon: Icon(
//                   Icons.notifications_none_rounded,
//                   color: isDarkMode ? Colors.white : AppColors.textDark,
//                   size: 22,
//                 ),
//                 tooltip: 'Notifications',
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//               ),
//               if (notificationCount > 0)
//                 Positioned(
//                   right: -4,
//                   top: -4,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 4.5, vertical: 1.5),
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryOrange,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(
//                       '$notificationCount',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),

//           if (!isMobile) ...[
//             const SizedBox(width: 18),

//             // Theme toggle button (moon/sun icon) on Desktop
//             IconButton(
//               onPressed: onThemeToggle,
//               icon: Icon(
//                 isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round_outlined,
//                 color: isDarkMode ? Colors.amber : AppColors.textDark,
//                 size: 20,
//               ),
//               tooltip: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
//               padding: EdgeInsets.zero,
//               constraints: const BoxConstraints(),
//             ),
//           ],

//           const SizedBox(width: 18),

//           // User Avatar: Orange circle with "SI"
//           InkWell(
//             onTap: onProfilePressed ??
//                 () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: const Text('Logged in as Yuvaraj (Admin)'),
//                       behavior: SnackBarBehavior.floating,
//                       backgroundColor:
//                           isDarkMode ? const Color(0xFF334155) : const Color(0xFF1E293B),
//                     ),
//                   );
//                 },
//             borderRadius: BorderRadius.circular(20),
//             child: Container(
//               width: 36,
//               height: 36,
//               decoration: const BoxDecoration(
//                 color: AppColors.primaryOrange,
//                 shape: BoxShape.circle,
//               ),
//               alignment: Alignment.center,
//               child: Text(
//                 userInitials,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 13,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:apache_connect/domain/entities/user.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../routes/app_routes.dart';

/// Reusable Common Top AppBar across Dashboard, Messages, and Documents.
/// Supports both Desktop/Web and Mobile compact layouts.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final bool isMobile;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onThemeToggle;
  final VoidCallback? onProfilePressed;
  final bool isDarkMode;
  final int notificationCount;
  final String userInitials;
  final List<Widget>? actions;
  final User? user;
  final ValueChanged<int>? onNavItemSelected;

  const AppTopBar({
    super.key,
    this.title = AppStrings.dashboardTitle,
    this.titleWidget,
    required this.isMobile,
    this.onMenuPressed,
    this.onNotificationPressed,
    this.onThemeToggle,
    this.onProfilePressed,
    this.isDarkMode = false,
    this.notificationCount = 6,
    this.userInitials = 'Yuvi',
    this.actions,
    this.user,
    this.onNavItemSelected,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final menuTextColor = isDarkMode ? Colors.white : const Color(0xFF1E293B);
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color:
                isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Left: Menu / Sidebar toggle icon
          IconButton(
            onPressed: onMenuPressed ??
                () {
                  if (isMobile) {
                    Scaffold.maybeOf(context)?.openDrawer();
                  }
                },
            icon: Icon(
              isMobile ? Icons.menu_rounded : Icons.view_sidebar_outlined,
              color: isDarkMode ? Colors.white : AppColors.textDark,
              size: 22,
            ),
            tooltip: isMobile ? 'Open Menu' : 'Toggle Sidebar',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),

          const SizedBox(width: 16),

          // Title
          titleWidget ??
              Text(
                title,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : AppColors.textDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),

          const Spacer(),

          if (actions != null) ...actions!,

          // Right: Notification Bell with Badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: onNotificationPressed ??
                    () {
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.notifications);
                    },
                icon: Icon(
                  Icons.notifications_none_rounded,
                  color: isDarkMode ? Colors.white : AppColors.textDark,
                  size: 22,
                ),
                tooltip: 'Notifications',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              if (notificationCount > 0)
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.5, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: AppColors.primaryOrange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          if (!isMobile) ...[
            const SizedBox(width: 18),

            // Theme toggle button (moon/sun icon) on Desktop
            IconButton(
              onPressed: onThemeToggle,
              icon: Icon(
                isDarkMode
                    ? Icons.wb_sunny_outlined
                    : Icons.nightlight_round_outlined,
                color: isDarkMode ? Colors.amber : AppColors.textDark,
                size: 20,
              ),
              tooltip:
                  isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],

          const SizedBox(width: 18),

          // User Avatar: Orange circle with "SI"
          // InkWell(
          //   onTap: onProfilePressed ??
          //       () {
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(
          //             content: const Text('Logged in as Syed Imran (Admin)'),
          //             behavior: SnackBarBehavior.floating,
          //             backgroundColor: isDarkMode
          //                 ? const Color(0xFF334155)
          //                 : const Color(0xFF1E293B),
          //           ),
          //         );
          //       },
          //   borderRadius: BorderRadius.circular(20),
          //   child: Container(
          //     width: 36,
          //     height: 36,
          //     decoration: const BoxDecoration(
          //       color: AppColors.primaryOrange,
          //       shape: BoxShape.circle,
          //     ),
          //     alignment: Alignment.center,
          //     child: Text(
          //       userInitials,
          //       style: const TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.w700,
          //         fontSize: 13,
          //       ),
          //     ),
          //   ),
          // ),

          // Right: User Avatar
          // InkWell(
          //   onTap: onProfilePressed,
          //   borderRadius: BorderRadius.circular(20),
          //   child: Container(
          //     width: 36,
          //     height: 36,
          //     decoration: const BoxDecoration(
          //       color: AppColors.primaryOrange,
          //       shape: BoxShape.circle,
          //     ),
          //     alignment: Alignment.center,
          //     child: Text(
          //       userInitials,
          //       style: const TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.w700,
          //         fontSize: 13,
          //       ),
          //     ),
          //   ),
          // ),

          // Common profile menu for every screen
          PopupMenuButton<String>(
            tooltip: 'Profile menu',
            offset: const Offset(0, 44),
            color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            onSelected: (value) {
              switch (value) {
                case 'profile':
                case 'password':
                  // Open ProfileScreen for both actions.
                  onNavItemSelected?.call(5);
                  break;

                case 'theme':
                  onThemeToggle?.call();
                  break;

                case 'signout':
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.login,
                    (route) => false,
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                enabled: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yuvaraj',
                      style: TextStyle(
                        color: menuTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      'Admin',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person_outline, color: menuTextColor),
                    const SizedBox(width: 12),
                    Text(
                      'My profile',
                      style: TextStyle(color: menuTextColor),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'password',
                child: Row(
                  children: [
                    Icon(Icons.key_outlined, color: menuTextColor),
                    const SizedBox(width: 12),
                    Text(
                      'Change password',
                      style: TextStyle(color: menuTextColor),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'theme',
                child: Row(
                  children: [
                    Icon(
                      isDarkMode
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      color: menuTextColor,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isDarkMode ? 'Light mode' : 'Dark mode',
                      style: TextStyle(color: menuTextColor),
                    ),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'signout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 12),
                    Text(
                      'Sign out',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.primaryOrange,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                userInitials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
