// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import '../constants/app_colors.dart';
// // import '../constants/app_dimens.dart';

// // class AppTheme {
// //   AppTheme._();

// //   static ThemeData get darkTheme {
// //     final textTheme = GoogleFonts.interTextTheme(ThemeData.dark().textTheme);

// //     return ThemeData(
// //       useMaterial3: true,
// //       brightness: Brightness.dark,
// //       scaffoldBackgroundColor: Colors.black,
// //       primaryColor: AppColors.primaryOrange,
// //       colorScheme: const ColorScheme.dark(
// //         primary: AppColors.primaryOrange,
// //         secondary: AppColors.primaryOrangeHover,
// //         surface: Color(0xFF1E293B),
// //         error: AppColors.error,
// //       ),
// //       textTheme: textTheme.copyWith(
// //         headlineMedium: textTheme.headlineMedium?.copyWith(
// //           color: AppColors.textWhite,
// //           fontWeight: FontWeight.w700,
// //           fontSize: 26.0,
// //           letterSpacing: -0.5,
// //         ),
// //         bodyMedium: textTheme.bodyMedium?.copyWith(
// //           color: AppColors.textSecondary,
// //           fontSize: 14.0,
// //         ),
// //         labelMedium: textTheme.labelMedium?.copyWith(
// //           color: AppColors.textWhite,
// //           fontSize: 13.0,
// //           fontWeight: FontWeight.w500,
// //         ),
// //       ),
// //       inputDecorationTheme: InputDecorationTheme(
// //         filled: true,
// //         fillColor: AppColors.inputBackground,
// //         contentPadding: const EdgeInsets.symmetric(
// //           horizontal: AppDimens.spacingMd,
// //           vertical: 14.0,
// //         ),
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(AppDimens.inputBorderRadius),
// //           borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.0),
// //         ),
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(AppDimens.inputBorderRadius),
// //           borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.0),
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(AppDimens.inputBorderRadius),
// //           borderSide: const BorderSide(color: AppColors.inputFocusedBorder, width: 1.5),
// //         ),
// //         errorBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(AppDimens.inputBorderRadius),
// //           borderSide: const BorderSide(color: AppColors.inputErrorBorder, width: 1.0),
// //         ),
// //         focusedErrorBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(AppDimens.inputBorderRadius),
// //           borderSide: const BorderSide(color: AppColors.inputErrorBorder, width: 1.5),
// //         ),
// //         hintStyle: const TextStyle(
// //           color: AppColors.textMuted,
// //           fontSize: 14.0,
// //         ),
// //       ),
// //     );
// //   }
// // }



// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../constants/app_colors.dart';
// import '../constants/app_dimens.dart';

// class AppTheme {
//   AppTheme._();

//   static ThemeData get darkTheme {
//     final baseTheme = ThemeData.dark();

//     // Apply the Inter font family without passing TextTheme
//     // into GoogleFonts.interTextTheme().
//     final TextTheme textTheme = baseTheme.textTheme.apply(
//       fontFamily: GoogleFonts.inter().fontFamily,
//     );

//     // return baseTheme.copyWith(
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.dark,
//       scaffoldBackgroundColor: Colors.black,
//       primaryColor: AppColors.primaryOrange,

//       colorScheme: const ColorScheme.dark(
//         primary: AppColors.primaryOrange,
//         secondary: AppColors.primaryOrangeHover,
//         surface: Color(0xFF1E293B),
//         error: AppColors.error,
//       ),

//       textTheme: textTheme.copyWith(
//         headlineMedium: textTheme.headlineMedium?.copyWith(
//           color: AppColors.textWhite,
//           fontWeight: FontWeight.w700,
//           fontSize: 26.0,
//           letterSpacing: -0.5,
//         ),
//         bodyMedium: textTheme.bodyMedium?.copyWith(
//           color: AppColors.textSecondary,
//           fontSize: 14.0,
//         ),
//         labelMedium: textTheme.labelMedium?.copyWith(
//           color: AppColors.textWhite,
//           fontSize: 13.0,
//           fontWeight: FontWeight.w500,
//         ),
//       ),

//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: AppColors.inputBackground,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: AppDimens.spacingMd,
//           vertical: 14.0,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(
//             AppDimens.inputBorderRadius,
//           ),
//           borderSide: const BorderSide(
//             color: AppColors.inputBorder,
//             width: 1.0,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(
//             AppDimens.inputBorderRadius,
//           ),
//           borderSide: const BorderSide(
//             color: AppColors.inputBorder,
//             width: 1.0,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(
//             AppDimens.inputBorderRadius,
//           ),
//           borderSide: const BorderSide(
//             color: AppColors.inputFocusedBorder,
//             width: 1.5,
//           ),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(
//             AppDimens.inputBorderRadius,
//           ),
//           borderSide: const BorderSide(
//             color: AppColors.inputErrorBorder,
//             width: 1.0,
//           ),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(
//             AppDimens.inputBorderRadius,
//           ),
//           borderSide: const BorderSide(
//             color: AppColors.inputErrorBorder,
//             width: 1.5,
//           ),
//         ),
//         hintStyle: const TextStyle(
//           color: AppColors.textMuted,
//           fontSize: 14.0,
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final baseTheme = ThemeData.light();

    final TextTheme textTheme = baseTheme.textTheme.apply(
      fontFamily: GoogleFonts.inter().fontFamily,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      primaryColor: AppColors.primaryOrange,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryOrange,
        brightness: Brightness.light,
        surface: Colors.white,
        error: AppColors.error,
      ),

      textTheme: textTheme.copyWith(
        headlineMedium: textTheme.headlineMedium?.copyWith(
          color: const Color(0xFF111827),
          fontWeight: FontWeight.w700,
          fontSize: 26,
          letterSpacing: -0.5,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF4B5563),
          fontSize: 14,
        ),
        labelMedium: textTheme.labelMedium?.copyWith(
          color: const Color(0xFF111827),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spacingMd,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimens.inputBorderRadius,
          ),
          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimens.inputBorderRadius,
          ),
          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimens.inputBorderRadius,
          ),
          borderSide: const BorderSide(
            color: AppColors.primaryOrange,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimens.inputBorderRadius,
          ),
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimens.inputBorderRadius,
          ),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
        hintStyle: const TextStyle(
          color: Color(0xFF9CA3AF),
          fontSize: 14,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final baseTheme = ThemeData.dark();

    final TextTheme textTheme = baseTheme.textTheme.apply(
      fontFamily: GoogleFonts.inter().fontFamily,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: AppColors.primaryOrange,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryOrange,
        secondary: AppColors.primaryOrangeHover,
        surface: Color(0xFF1E293B),
        error: AppColors.error,
      ),

      textTheme: textTheme.copyWith(
        headlineMedium: textTheme.headlineMedium?.copyWith(
          color: AppColors.textWhite,
          fontWeight: FontWeight.w700,
          fontSize: 26,
          letterSpacing: -0.5,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
        labelMedium: textTheme.labelMedium?.copyWith(
          color: AppColors.textWhite,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spacingMd,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimens.inputBorderRadius,
          ),
          borderSide: const BorderSide(
            color: AppColors.inputBorder,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimens.inputBorderRadius,
          ),
          borderSide: const BorderSide(
            color: AppColors.inputBorder,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimens.inputBorderRadius,
          ),
          borderSide: const BorderSide(
            color: AppColors.inputFocusedBorder,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimens.inputBorderRadius,
          ),
          borderSide: const BorderSide(
            color: AppColors.inputErrorBorder,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimens.inputBorderRadius,
          ),
          borderSide: const BorderSide(
            color: AppColors.inputErrorBorder,
            width: 1.5,
          ),
        ),
        hintStyle: const TextStyle(
          color: AppColors.textMuted,
          fontSize: 14,
        ),
      ),
    );
  }
}
