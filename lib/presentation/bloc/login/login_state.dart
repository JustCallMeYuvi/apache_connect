import 'package:equatable/equatable.dart';
import '../../../domain/entities/user.dart';

enum LoginStatus { initial, submitting, success, failure }

class LoginState extends Equatable {
  final String username;
  final String password;
  final bool isPasswordObscured;
  final bool rememberMe;
  final LoginStatus status;
  final String? errorMessage;
  final String? usernameError;
  final String? passwordError;
  final User? authenticatedUser;

  const LoginState({
    this.username = '',
    this.password = '',
    this.isPasswordObscured = true,
    this.rememberMe = true, // Default checked as in the screenshot
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.usernameError,
    this.passwordError,
    this.authenticatedUser,
  });

  bool get isLoading => status == LoginStatus.submitting;
  bool get isSuccess => status == LoginStatus.success;
  bool get isFailure => status == LoginStatus.failure;

  // LoginState copyWith({
  //   String? username,
  //   String? password,
  //   bool? isPasswordObscured,
  //   bool? rememberMe,
  //   LoginStatus? status,
  //   String? errorMessage,
  //   String? usernameError,
  //   String? passwordError,
  //   User? authenticatedUser,
  //   bool clearErrors = false,
  // }) {
  //   return LoginState(
  //     username: username ?? this.username,
  //     password: password ?? this.password,
  //     isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
  //     rememberMe: rememberMe ?? this.rememberMe,
  //     status: status ?? this.status,
  //     errorMessage: clearErrors ? null : (errorMessage ?? this.errorMessage),
  //     usernameError: clearErrors ? null : (usernameError ?? this.usernameError),
  //     passwordError: clearErrors ? null : (passwordError ?? this.passwordError),
  //     authenticatedUser: authenticatedUser ?? this.authenticatedUser,
  //   );
  // }

    User get currentUser {
    return authenticatedUser ??
        const User(
          id: 'APC1001',
          username: 'imran@apache.co',
          email: 'imran@apache.co',
          displayName: 'Syed Imran',
          token: '58v0xkgw••••••',
          phone: '+91 90000 01000',
          barcode: 'APC1001',
          department: 'IT',
          factory: 'APC',
          designation: 'System Admin',
          role: 'Admin',
          status: 'Active',
        );
  }
  LoginState copyWith({
    String? username,
    String? password,
    bool? isPasswordObscured,
    bool? rememberMe,
    LoginStatus? status,
    String? errorMessage,
    String? usernameError,
    String? passwordError,
    User? authenticatedUser,
    bool clearErrors = false,
    bool clearAuthenticatedUser = false,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      rememberMe: rememberMe ?? this.rememberMe,
      status: status ?? this.status,
      errorMessage: clearErrors ? null : (errorMessage ?? this.errorMessage),
      usernameError: clearErrors ? null : (usernameError ?? this.usernameError),
      passwordError: clearErrors ? null : (passwordError ?? this.passwordError),
      authenticatedUser: clearAuthenticatedUser
          ? null
          : (authenticatedUser ?? this.authenticatedUser),
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        isPasswordObscured,
        rememberMe,
        status,
        errorMessage,
        usernameError,
        passwordError,
        authenticatedUser,
      ];
}
