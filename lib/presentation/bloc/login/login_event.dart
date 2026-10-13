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
