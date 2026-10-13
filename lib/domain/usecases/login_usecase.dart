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
    return await _repository.login(
      username: username,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
