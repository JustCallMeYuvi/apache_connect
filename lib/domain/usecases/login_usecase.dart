// import '../../core/network/api_result.dart';
// import '../entities/user.dart';
// import '../repositories/auth_repository.dart';

// /// Clean Architecture Use Case executing the login action
// class LoginUseCase {
//   final AuthRepository _repository;

//   LoginUseCase(this._repository);

//   Future<ApiResult<User>> execute({
//     required String username,
//     required String password,
//     required bool rememberMe,
//   }) async {
//     return await _repository.login(
//       username: username,
//       password: password,
//       rememberMe: rememberMe,
//     );
//   }
// }



import 'package:flutter/foundation.dart';

import '../../core/network/api_result.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Clean Architecture Use Case executing the login action
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<ApiResult<User>> execute({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    debugPrint('USECASE DEBUG: execute started');
    debugPrint('USECASE DEBUG: Username = [$username]');
    debugPrint('USECASE DEBUG: Password length = ${password.length}');
    debugPrint('USECASE DEBUG: Remember me = $rememberMe');

    try {
      debugPrint('USECASE DEBUG: Calling AuthRepository.login');

      final result = await _repository.login(
        username: username,
        password: password,
        rememberMe: rememberMe,
      );

      debugPrint('USECASE DEBUG: Repository call completed');
      debugPrint('USECASE DEBUG: Result type = ${result.runtimeType}');

      if (result is Success<User>) {
        debugPrint('USECASE DEBUG: Login SUCCESS');
      } else if (result is Failure<User>) {
        debugPrint('USECASE DEBUG: Login FAILED');
        debugPrint('USECASE DEBUG: Error = ${result.errorMessage}');
      }

      return result;
    } catch (e, stackTrace) {
      debugPrint('USECASE DEBUG: Exception = $e');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }
}
