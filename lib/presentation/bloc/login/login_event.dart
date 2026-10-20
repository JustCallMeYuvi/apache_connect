import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched when the user types in the username/email input field
class LoginUsernameChanged extends LoginEvent {
  final String username;
  const LoginUsernameChanged(this.username);

  @override
  List<Object?> get props => [username];
}

/// Dispatched when the user types in the password input field
class LoginPasswordChanged extends LoginEvent {
  final String password;
  const LoginPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

/// Dispatched when the user toggles the eye icon in the password field
class LoginPasswordVisibilityToggled extends LoginEvent {
  const LoginPasswordVisibilityToggled();
}

/// Dispatched when the user clicks the "Keep me signed in" checkbox
class LoginRememberMeToggled extends LoginEvent {
  final bool rememberMe;
  const LoginRememberMeToggled(this.rememberMe);

  @override
  List<Object?> get props => [rememberMe];
}

/// Dispatched when the user clicks the orange "Sign in" button or presses Enter
class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

/// Dispatched to reset the form state
class LoginReset extends LoginEvent {
  const LoginReset();
}



/// Dispatched to update personal information from the My Profile screen
class UpdateProfileEvent extends LoginEvent {
  final String fullName;
  final String email;
  final String phone;

  const UpdateProfileEvent({
    required this.fullName,
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [fullName, email, phone];
}

/// Dispatched to update the password from the My Profile screen
class ChangePasswordEvent extends LoginEvent {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword];
}

/// Dispatched to clear session and sign out
class SignOutEvent extends LoginEvent {
  const SignOutEvent();
}