import '../../core/network/api_result.dart';
import '../entities/user.dart';

/// Abstract contract for authentication repository in domain layer
abstract class AuthRepository {
  Future<ApiResult<User>> login({
    required String username,
    required String password,
    required bool rememberMe,
  });

  Future<void> logout();

  Future<User?> getCurrentUser();
}
