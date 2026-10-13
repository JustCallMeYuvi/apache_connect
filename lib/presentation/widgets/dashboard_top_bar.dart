// import 'package:flutter/material.dart';
// import '../../core/constants/app_colors.dart';
// import '../../core/constants/app_strings.dart';

// class DashboardTopBar extends StatelessWidget implements PreferredSizeWidget {
//   final bool isMobile;
//   final VoidCallback? onMenuPressed;
//   final VoidCallback? onNotificationPressed;
//   final VoidCallback? onThemeToggle;
//   final VoidCallback? onProfilePressed;
//   final bool isDarkMode;

//   const DashboardTopBar({
//     super.key,
//     required this.isMobile,
//     this.onMenuPressed,
//     this.onNotificationPressed,
//     this.onThemeToggle,
//     this.onProfilePressed,
//     this.isDarkMode = false,
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
//             color:
//                 isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(
//         children: [
//           // Left: Menu / Sidebar toggle icon
//           IconButton(
//             onPressed: onMenuPressed,
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

//           // Title: "Dashboard"
//           Text(
//             AppStrings.dashboardTitle,
//             style: TextStyle(
//               color: isDarkMode ? Colors.white : AppColors.textDark,
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               letterSpacing: -0.2,
//             ),
//           ),

//           const Spacer(),

//           // Right: Notification Bell with Badge 6
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               IconButton(
//                 onPressed: onNotificationPressed,
//                 icon: Icon(
//                   Icons.notifications_none_rounded,
//                   color: isDarkMode ? Colors.white : AppColors.textDark,
//                   size: 22,
//                 ),
//                 tooltip: 'Notifications',
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//               ),
//               Positioned(
//                 right: -4,
//                 top: -4,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 4.5, vertical: 1.5),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryOrange,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Text(
//                     '6',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 10,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           if (!isMobile) ...[
//             const SizedBox(width: 18),

//             // Theme toggle button (moon/sun icon)
//             IconButton(
//               onPressed: onThemeToggle,
//               icon: Icon(
//                 isDarkMode
//                     ? Icons.wb_sunny_outlined
//                     : Icons.nightlight_round_outlined,
//                 color: isDarkMode ? Colors.amber : AppColors.textDark,
//                 size: 20,
//               ),
//               tooltip:
//                   isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
//               padding: EdgeInsets.zero,
//               constraints: const BoxConstraints(),
//             ),
//           ],

//           const SizedBox(width: 18),

//           // User Avatar: Orange circle with "Yuvi" initials
//           InkWell(
//             onTap: onProfilePressed,
//             borderRadius: BorderRadius.circular(20),
//             child: Container(
//               width: 36,
//               height: 36,
//               decoration: const BoxDecoration(
//                 color: AppColors.primaryOrange,
//                 shape: BoxShape.circle,
//               ),
//               alignment: Alignment.center,
//               child: const Text(
//                 'Yuvi',
//                 style: TextStyle(
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


export 'app_top_bar.dart';
import 'app_top_bar.dart';

/// Legacy alias for AppTopBar for backward compatibility
typedef DashboardTopBar = AppTopBar;
