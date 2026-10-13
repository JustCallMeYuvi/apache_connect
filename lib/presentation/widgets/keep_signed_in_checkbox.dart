import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class KeepSignedInAndForgotRow extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onCheckedChanged;
  final VoidCallback onForgotPasswordPressed;

  const KeepSignedInAndForgotRow({
    super.key,
    required this.isChecked,
    required this.onCheckedChanged,
    required this.onForgotPasswordPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side: Custom Checkbox + Keep me signed in
        InkWell(
          onTap: () => onCheckedChanged(!isChecked),
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: isChecked ? AppColors.primaryOrange : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isChecked ? AppColors.primaryOrange : AppColors.textMuted,
                      width: 1.5,
                    ),
                  ),
                  child: isChecked
                      ? const Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.white,
                        )
                      : null,
                ),
                const SizedBox(width: 8),
                const Text(
                  AppStrings.keepMeSignedIn,
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Right side: Forgot password?
        TextButton(
          onPressed: onForgotPasswordPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: AppColors.textLink,
          ),
          child: const Text(
            AppStrings.forgotPassword,
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
