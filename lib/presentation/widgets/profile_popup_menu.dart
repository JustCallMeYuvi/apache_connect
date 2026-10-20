// import 'package:apache_connect/domain/entities/dashboard_data.dart';
// import 'package:flutter/material.dart';
// import '../../core/constants/app_colors.dart';
// import '../../routes/app_routes.dart';
// import 'sign_out_dialog.dart';

// /// Floating profile menu anchored to top bar avatar.
// class ProfilePopupMenu extends StatelessWidget {
//   final UserProfile user;
//   final bool isDarkMode;
//   final VoidCallback? onThemeToggle;
//   final VoidCallback? onSignOut;

//   const ProfilePopupMenu({
//     super.key,
//     required this.user,
//     this.isDarkMode = false,
//     this.onThemeToggle,
//     this.onSignOut,
//   });

//   static void show(
//     BuildContext context, {
//     required UserProfile user,
//     bool isDarkMode = false,
//     VoidCallback? onThemeToggle,
//     VoidCallback? onSignOut,
//   }) {
//     final RenderBox? overlay =
//         Overlay.of(context).context.findRenderObject() as RenderBox?;

//     if (overlay == null) return;

//     final mediaQuery = MediaQuery.of(context);
//     final isMobile = mediaQuery.size.width < 960;

//     final position = RelativeRect.fromRect(
//       Rect.fromLTWH(
//         overlay.size.width - (isMobile ? 240 : 260),
//         60,
//         isMobile ? 220 : 240,
//         250,
//       ),
//       Offset.zero & overlay.size,
//     );

//     showMenu<String>(
//       context: context,
//       position: position,
//       color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(
//           color: isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
//         ),
//       ),
//       elevation: 10,
//       items: [
//         // User header
//         PopupMenuItem<String>(
//           enabled: false,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 // user.safeDisplayName,
//                 user.name,
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w700,
//                   color: isDarkMode ? Colors.white : AppColors.textDark,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 // user.safeEmail,
//                 user.role,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: Color(0xFF94A3B8),
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Divider(
//                 height: 1,
//                 color: isDarkMode
//                     ? const Color(0x1AFFFFFF)
//                     : const Color(0xFFE2E8F0),
//               ),
//             ],
//           ),
//         ),

//         // My profile
//         PopupMenuItem<String>(
//           value: 'profile',
//           child: Row(
//             children: [
//               Icon(
//                 Icons.person_outline_rounded,
//                 size: 19,
//                 color: isDarkMode ? Colors.white70 : AppColors.textDark,
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 'My profile',
//                 style: TextStyle(
//                   fontSize: 13.5,
//                   fontWeight: FontWeight.w500,
//                   color: isDarkMode ? Colors.white : AppColors.textDark,
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Change password
//         PopupMenuItem<String>(
//           value: 'change_password',
//           child: Row(
//             children: [
//               Icon(
//                 Icons.key_outlined,
//                 size: 19,
//                 color: isDarkMode ? Colors.white70 : AppColors.textDark,
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 'Change password',
//                 style: TextStyle(
//                   fontSize: 13.5,
//                   fontWeight: FontWeight.w500,
//                   color: isDarkMode ? Colors.white : AppColors.textDark,
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Dark mode
//         PopupMenuItem<String>(
//           value: 'dark_mode',
//           child: Row(
//             children: [
//               Icon(
//                 isDarkMode
//                     ? Icons.wb_sunny_outlined
//                     : Icons.nightlight_round_outlined,
//                 size: 19,
//                 color: isDarkMode ? Colors.amber : AppColors.textDark,
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 isDarkMode ? 'Light mode' : 'Dark mode',
//                 style: TextStyle(
//                   fontSize: 13.5,
//                   fontWeight: FontWeight.w500,
//                   color: isDarkMode ? Colors.white : AppColors.textDark,
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Sign out
//         const PopupMenuItem<String>(
//           value: 'sign_out',
//           child: Row(
//             children: [
//               Icon(
//                 Icons.logout_rounded,
//                 size: 19,
//                 color: Color(0xFFDC2626),
//               ),
//               SizedBox(width: 12),
//               Text(
//                 'Sign out',
//                 style: TextStyle(
//                   fontSize: 13.5,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFFDC2626),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ).then((value) {
//       // Prevent using context after its widget tree is disposed.
//       if (!context.mounted || value == null) return;

//       if (value == 'profile' || value == 'change_password') {
//         Navigator.of(context).pushNamed(AppRoutes.profile);
//       } else if (value == 'dark_mode') {
//         onThemeToggle?.call();
//       } else if (value == 'sign_out') {
//         SignOutDialog.show(
//           context,
//           isDarkMode: isDarkMode,
//           onConfirmSignOut: onSignOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox.shrink();
//   }
// }

import 'package:apache_connect/domain/entities/dashboard_data.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'sign_out_dialog.dart';

/// Floating profile menu anchored to the top bar avatar.
class ProfilePopupMenu extends StatelessWidget {
  final UserProfile user;
  final bool isDarkMode;
  final VoidCallback? onThemeToggle;
  final VoidCallback? onSignOut;

  const ProfilePopupMenu({
    super.key,
    required this.user,
    this.isDarkMode = false,
    this.onThemeToggle,
    this.onSignOut,
  });

  static Future<void> show(
    BuildContext context, {
    required UserProfile user,
    bool isDarkMode = false,
    VoidCallback? onThemeToggle,
    VoidCallback? onSignOut,
    VoidCallback? onOpenProfile,
  }) async {
    final overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox?;

    if (overlay == null || !overlay.hasSize || !context.mounted) {
      return;
    }

    final isMobile = MediaQuery.sizeOf(context).width < 960;

    final menuWidth = isMobile ? 220.0 : 240.0;

    final position = RelativeRect.fromRect(
      Rect.fromLTWH(
        overlay.size.width - menuWidth - 12,
        60,
        menuWidth,
        250,
      ),
      Offset.zero & overlay.size,
    );

    final value = await showMenu<String>(
      context: context,
      position: position,
      color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
        ),
      ),
      elevation: 10,
      items: [
        // User information
        PopupMenuItem<String>(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : AppColors.textDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                user.role,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 6),
              Divider(
                height: 1,
                color: isDarkMode
                    ? const Color(0x1AFFFFFF)
                    : const Color(0xFFE2E8F0),
              ),
            ],
          ),
        ),

        // My profile
        PopupMenuItem<String>(
          value: 'profile',
          child: _menuItem(
            icon: Icons.person_outline_rounded,
            title: 'My profile',
            isDarkMode: isDarkMode,
          ),
        ),

        // Change password
        PopupMenuItem<String>(
          value: 'change_password',
          child: _menuItem(
            icon: Icons.key_outlined,
            title: 'Change password',
            isDarkMode: isDarkMode,
          ),
        ),

        // Theme toggle
        PopupMenuItem<String>(
          value: 'dark_mode',
          child: _menuItem(
            icon: isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round_outlined,
            title: isDarkMode ? 'Light mode' : 'Dark mode',
            isDarkMode: isDarkMode,
            iconColor: isDarkMode ? Colors.amber : AppColors.textDark,
          ),
        ),

        // Sign out
        const PopupMenuItem<String>(
          value: 'sign_out',
          child: Row(
            children: [
              Icon(
                Icons.logout_rounded,
                size: 19,
                color: Color(0xFFDC2626),
              ),
              SizedBox(width: 12),
              Text(
                'Sign out',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFDC2626),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    // Dismissing the menu does not trigger navigation.
    if (!context.mounted || value == null) return;

    switch (value) {
      // case 'profile':
      //   Navigator.of(context).pushNamed(AppRoutes.profile);
      //   break;

      // case 'change_password':
      //   // Keep your existing route for now.
      //   Navigator.of(context).pushNamed(AppRoutes.profile);
      //   break;
      case 'profile':
case 'change_password':
  onOpenProfile?.call();
  break;

      case 'dark_mode':
        onThemeToggle?.call();
        break;

      case 'sign_out':
        SignOutDialog.show(
          context,
          isDarkMode: isDarkMode,
          onConfirmSignOut: onSignOut,
        );
        break;
    }
  }

  static Widget _menuItem({
    required IconData icon,
    required String title,
    required bool isDarkMode,
    Color? iconColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 19,
          color:
              iconColor ?? (isDarkMode ? Colors.white70 : AppColors.textDark),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.white : AppColors.textDark,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
