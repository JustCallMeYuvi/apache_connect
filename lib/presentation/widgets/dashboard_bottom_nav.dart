// import 'package:flutter/material.dart';
// import '../../core/constants/app_colors.dart';
// import '../../core/constants/app_strings.dart';

// class DashboardBottomNav extends StatelessWidget {
//   final int selectedIndex;
//   final ValueChanged<int> onIndexChanged;
//   final bool isDarkMode;

//   const DashboardBottomNav({
//     super.key,
//     required this.selectedIndex,
//     required this.onIndexChanged,
//     this.isDarkMode = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
//         border: Border(
//           top: BorderSide(
//             color: isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
//             width: 1,
//           ),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       child: SafeArea(
//         top: false,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildNavItem(
//               index: 0,
//               icon: Icons.home_outlined,
//               label: AppStrings.bottomHome,
//             ),
//             _buildNavItem(
//               index: 1,
//               icon: Icons.chat_bubble_outline_rounded,
//               label: AppStrings.bottomChats,
//               badgeText: '5',
//             ),
//             _buildNavItem(
//               index: 2,
//               icon: Icons.description_outlined,
//               label: AppStrings.bottomDocs,
//             ),
//             _buildNavItem(
//               index: 3,
//               icon: Icons.notifications_none_rounded,
//               label: AppStrings.bottomAlerts,
//               badgeText: '6',
//             ),
//             _buildNavItem(
//               index: 4,
//               icon: Icons.menu_rounded,
//               label: AppStrings.bottomMore,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem({
//     required int index,
//     required IconData icon,
//     required String label,
//     String? badgeText,
//   }) {
//     final isSelected = selectedIndex == index;

//     return InkWell(
//       onTap: () => onIndexChanged(index),
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? (isDarkMode ? const Color(0xFF332019) : AppColors.peachIconBg)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Icon(
//                   icon,
//                   size: 22,
//                   color: isSelected
//                       ? AppColors.primaryOrange
//                       : (isDarkMode ? const Color(0xFF94A3B8) : AppColors.textGray),
//                 ),
//                 if (badgeText != null)
//                   Positioned(
//                     right: -7,
//                     top: -4,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
//                       decoration: const BoxDecoration(
//                         color: AppColors.primaryOrange,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Text(
//                         badgeText,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 9.5,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 3),
//             Text(
//               label,
//               style: TextStyle(
//                 color: isSelected
//                     ? AppColors.primaryOrange
//                     : (isDarkMode ? const Color(0xFF94A3B8) : AppColors.textGray),
//                 fontSize: 11,
//                 fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:apache_connect/presentation/widgets/app_bottom_nav_bar.dart';

/// Legacy alias for AppBottomNav for backward compatibility
typedef DashboardBottomNav = AppBottomNav;
