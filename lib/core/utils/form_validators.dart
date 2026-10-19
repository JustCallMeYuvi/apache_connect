// import '../constants/app_strings.dart';

// class FormValidators {
//   FormValidators._();

//   /// Validates that username or email is not empty
//   static String? validateUsername(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return AppStrings.errUsernameRequired;
//     }
//     return null;
//   }

//   /// Validates password presence and minimum length
//   static String? validatePassword(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return AppStrings.errPasswordRequired;
//     }
//     if (value.trim().length < 6) {
//       return AppStrings.errPasswordTooShort;
//     }
//     return null;
//   }
// }

class FormValidators {
  static String? validateUsername(String value) {
    if (value.trim().isEmpty) {
      return 'Please enter your username or email';
    }

    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    }

    return null;
  }
}
