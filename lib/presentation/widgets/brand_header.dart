import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand logo row
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppDimens.logoSize,
              height: AppDimens.logoSize,
              decoration: BoxDecoration(
                color: AppColors.primaryOrange,
                borderRadius: BorderRadius.circular(AppDimens.logoRadius),
                boxShadow: [
                  BoxShadow(
                    // color: AppColors.primaryOrange.withOpacity(0.3),
                    color: AppColors.primaryOrange.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                'A',
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: 20.0,
                  height: 1.0,
                ),
              ),
            ),
            const SizedBox(width: AppDimens.spacingSm + 4),
            const Text(
              AppStrings.brandName,
              style: TextStyle(
                color: AppColors.textWhite,
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppDimens.spacingLg),

        // Welcome back header
        const Text(
          AppStrings.welcomeBack,
          style: TextStyle(
            color: AppColors.textWhite,
            fontWeight: FontWeight.w700,
            fontSize: 28.0,
            letterSpacing: -0.5,
          ),
        ),

        const SizedBox(height: AppDimens.spacingXs),

        // Subtitle
        const Text(
          AppStrings.signInSubtitle,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
