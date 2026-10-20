import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../routes/app_routes.dart';

/// Sign Out Confirmation Modal Dialog (Matches Screenshots 5 & 6)
class SignOutDialog extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback? onConfirmSignOut;

  const SignOutDialog({
    super.key,
    this.isDarkMode = false,
    this.onConfirmSignOut,
  });

  static Future<void> show(
    BuildContext context, {
    bool isDarkMode = false,
    VoidCallback? onConfirmSignOut,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => SignOutDialog(
        isDarkMode: isDarkMode,
        onConfirmSignOut: onConfirmSignOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      titlePadding: const EdgeInsets.fromLTRB(24, 20, 16, 0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Sign out?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : AppColors.textDark,
              letterSpacing: -0.2,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_rounded, size: 20),
            color: const Color(0xFF94A3B8),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            tooltip: 'Close',
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          Text(
            'You will need to sign in again to access your workspace.',
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? const Color(0xFF94A3B8) : AppColors.textGray,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Cancel Button
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDarkMode ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                  foregroundColor:
                      isDarkMode ? Colors.white : const Color(0xFF1E293B),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 12),
              // Sign out Button (Red)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirmSignOut != null) {
                    onConfirmSignOut!();
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.login,
                      (route) => false,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626), // Solid red matching screenshot
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                ),
                child: const Text(
                  'Sign out',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
