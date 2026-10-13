// import 'package:flutter/material.dart';
// import '../../core/constants/app_colors.dart';
// import '../../core/constants/app_strings.dart';
// import '../../routes/app_routes.dart';

// class DashboardSidebar extends StatelessWidget {
//   final int selectedIndex;
//   final ValueChanged<int> onItemSelected;
//   final VoidCallback? onSignOut;

//   const DashboardSidebar({
//     super.key,
//     required this.selectedIndex,
//     required this.onItemSelected,
//     this.onSignOut,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 250,
//       color: AppColors.sidebarBg,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // 1. Top Logo Header
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, top: 22, bottom: 20),
//             child: Row(
//               children: [
//                 Container(
//                   width: 38,
//                   height: 38,
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryOrange,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.primaryOrange.withOpacity(0.3),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   alignment: Alignment.center,
//                   child: const Text(
//                     'A',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w800,
//                       fontSize: 22,
//                       height: 1.0,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 const Text(
//                   AppStrings.brandName,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 18,
//                     letterSpacing: -0.3,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // 2. Navigation items list (Scrollable if viewport height is small)
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               children: [
//                 _buildNavItem(
//                   index: 0,
//                   icon: Icons.dashboard_outlined,
//                   label: AppStrings.navDashboard,
//                 ),
//                 _buildNavItem(
//                   index: 1,
//                   icon: Icons.chat_bubble_outline_rounded,
//                   label: AppStrings.navMessages,
//                   badgeText: '5',
//                 ),
//                 _buildNavItem(
//                   index: 2,
//                   icon: Icons.description_outlined,
//                   label: AppStrings.navDocuments,
//                 ),
//                 _buildNavItem(
//                   index: 3,
//                   icon: Icons.notifications_none_rounded,
//                   label: AppStrings.navNotifications,
//                   badgeText: '6',
//                 ),

//                 const SizedBox(height: 20),

//                 // Administration Header
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   child: Text(
//                     AppStrings.administrationHeader,
//                     style: TextStyle(
//                       color: AppColors.sidebarSectionHeader,
//                       fontSize: 11,
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: 0.8,
//                     ),
//                   ),
//                 ),

//                 _buildNavItem(
//                   index: 4,
//                   icon: Icons.grid_view_rounded,
//                   label: AppStrings.navAdminDashboard,
//                 ),
//                 _buildNavItem(
//                   index: 5,
//                   icon: Icons.people_outline_rounded,
//                   label: AppStrings.navUsers,
//                 ),
//                 _buildNavItem(
//                   index: 6,
//                   icon: Icons.shield_outlined,
//                   label: AppStrings.navRoles,
//                 ),
//                 _buildNavItem(
//                   index: 7,
//                   icon: Icons.tune_rounded,
//                   label: AppStrings.navAccessMatrix,
//                 ),
//                 _buildNavItem(
//                   index: 8,
//                   icon: Icons.key_outlined,
//                   label: AppStrings.navRoleAssignment,
//                 ),
//                 _buildNavItem(
//                   index: 9,
//                   icon: Icons.domain_rounded,
//                   label: AppStrings.navFactories,
//                 ),
//                 _buildNavItem(
//                   index: 10,
//                   icon: Icons.location_on_outlined,
//                   label: AppStrings.navLocations,
//                 ),
//                 _buildNavItem(
//                   index: 11,
//                   icon: Icons.list_alt_rounded,
//                   label: AppStrings.navDocCategories,
//                 ),
//               ],
//             ),
//           ),

//           // 3. User Profile Card & Sign Out at bottom
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             decoration: const BoxDecoration(
//               border: Border(
//                 top: BorderSide(color: Color(0x1AFFFFFF), width: 1),
//               ),
//             ),
//             child: Column(
//               children: [
//                 // Profile row
//                 Row(
//                   children: [
//                     Container(
//                       width: 36,
//                       height: 36,
//                       decoration: const BoxDecoration(
//                         color: AppColors.primaryOrange,
//                         shape: BoxShape.circle,
//                       ),
//                       alignment: Alignment.center,
//                       child: const Text(
//                         'SI',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     const Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Yuvaraj',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 13.5,
//                             ),
//                           ),
//                           Text(
//                             'Admin',
//                             style: TextStyle(
//                               color: AppColors.sidebarText,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 12),

//                 // Sign out button
//                 InkWell(
//                   onTap: () {
//                     if (onSignOut != null) {
//                       onSignOut!();
//                     } else {
//                       Navigator.of(context).pushReplacementNamed(AppRoutes.login);
//                     }
//                   },
//                   borderRadius: BorderRadius.circular(8),
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.logout_rounded,
//                           color: AppColors.sidebarText,
//                           size: 18,
//                         ),
//                         SizedBox(width: 10),
//                         Text(
//                           AppStrings.signOut,
//                           style: TextStyle(
//                             color: AppColors.sidebarText,
//                             fontSize: 13,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
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

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () => onItemSelected(index),
//           borderRadius: BorderRadius.circular(10),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//             decoration: BoxDecoration(
//               color: isSelected ? AppColors.primaryOrange : Colors.transparent,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   icon,
//                   size: 20,
//                   color: isSelected ? Colors.white : AppColors.sidebarText,
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Text(
//                     label,
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : AppColors.sidebarText,
//                       fontSize: 13.5,
//                       fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 if (badgeText != null)
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: isSelected ? Colors.white : const Color(0xFFF1F5F9),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       badgeText,
//                       style: TextStyle(
//                         color: isSelected ? AppColors.primaryOrange : const Color(0xFF1E293B),
//                         fontSize: 11,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:apache_connect/presentation/widgets/app_sidebar.dart';

/// Legacy alias for AppSidebar for backward compatibility
typedef DashboardSidebar = AppSidebar;
