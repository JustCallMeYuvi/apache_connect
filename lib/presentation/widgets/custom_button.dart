import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = AppDimens.buttonHeight,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.onPressed == null
        // ? AppColors.primaryOrange.withOpacity(0.5)
        ? AppColors.primaryOrange.withValues(alpha: 0.5)

        : _isHovered
            ? AppColors.primaryOrangeHover
            : AppColors.primaryOrange;

    return MouseRegion(
      cursor: widget.onPressed != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height,
        child: ElevatedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: effectiveColor,
            foregroundColor: AppColors.textWhite,
            // disabledBackgroundColor: AppColors.primaryOrange.withOpacity(0.6),
            disabledBackgroundColor: AppColors.primaryOrange.withValues(alpha: 0.6),

            disabledForegroundColor: AppColors.textWhite.withValues(alpha: 0.7),
            elevation: _isHovered ? 4 : 1,
            shadowColor: AppColors.primaryOrange.withValues(alpha: 0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.buttonBorderRadius),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.spacingLg,
              vertical: 12.0,
            ),
          ),
          child: widget.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  widget.text,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                  ),
                ),
        ),
      ),
    );
  }
}
