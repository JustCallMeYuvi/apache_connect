import 'package:apache_connect/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_result.dart';
import '../../../core/utils/form_validators.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<LoginRememberMeToggled>(_onRememberMeToggled);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginReset>(_onReset);
  }

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      username: event.username,
      usernameError: null,
      errorMessage: null,
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      password: event.password,
      passwordError: null,
      errorMessage: null,
    ));
  }

  void _onPasswordVisibilityToggled(
    LoginPasswordVisibilityToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      isPasswordObscured: !state.isPasswordObscured,
    ));
  }

  void _onRememberMeToggled(
    LoginRememberMeToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      rememberMe: event.rememberMe,
    ));
  }

  // Future<void> _onSubmitted(
  //   LoginSubmitted event,
  //   Emitter<LoginState> emit,
  // ) async {
  //   final usernameError = FormValidators.validateUsername(state.username);
  //   final passwordError = FormValidators.validatePassword(state.password);

  //   if (usernameError != null || passwordError != null) {
  //     emit(state.copyWith(
  //       usernameError: usernameError,
  //       passwordError: passwordError,
  //       status: LoginStatus.failure,
  //     ));
  //     return;
  //   }

  //   emit(state.copyWith(
  //     status: LoginStatus.submitting,
  //     errorMessage: null,
  //     usernameError: null,
  //     passwordError: null,
  //   ));

  //   final result = await _loginUseCase.execute(
  //     username: state.username,
  //     password: state.password,
  //     rememberMe: state.rememberMe,
  //   );

  //   if (result is Success) {
  //     emit(state.copyWith(
  //       status: LoginStatus.success,
  //       authenticatedUser: result.data,
  //     ));
  //   } else if (result is Failure) {
  //     emit(state.copyWith(
  //       status: LoginStatus.failure,
  //       errorMessage: result.errorMessage,
  //     ));
  //   }
  // }



Future<void> _onSubmitted(
  LoginSubmitted event,
  Emitter<LoginState> emit,
) async {
  final usernameError =
      FormValidators.validateUsername(state.username);
  final passwordError =
      FormValidators.validatePassword(state.password);

  if (usernameError != null || passwordError != null) {
    emit(state.copyWith(
      usernameError: usernameError,
      passwordError: passwordError,
      status: LoginStatus.failure,
    ));
    return;
  }

  emit(state.copyWith(
    status: LoginStatus.submitting,
    errorMessage: null,
    usernameError: null,
    passwordError: null,
  ));

  final result = await _loginUseCase.execute(
    username: state.username,
    password: state.password,
    rememberMe: state.rememberMe,
  );

  if (result is Success<User>) {
    emit(state.copyWith(
      status: LoginStatus.success,
      authenticatedUser: result.data,
    ));
  } else if (result is Failure<User>) {
    emit(state.copyWith(
      status: LoginStatus.failure,
      errorMessage: result.errorMessage,
    ));
  }
}

  void _onReset(
    LoginReset event,
    Emitter<LoginState> emit,
  ) {
    emit(const LoginState());
  }
}
