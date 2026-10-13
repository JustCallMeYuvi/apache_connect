import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String username,
    required String password,
    required bool rememberMe,
  });
}

/// Production-ready mock / placeholder datasource with realistic network latency,
/// easily swappable with http.Client when connected to the ApacheConnect REST backend.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // In a production backend scenario, inject http.Client or Dio
  // final http.Client client;

  AuthRemoteDataSourceImpl();

  @override
  Future<UserModel> login({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    // Simulate real network trip
    await Future.delayed(const Duration(milliseconds: 1200));

    // Basic authentication simulation
    // Allows default preview user from screenshot: Imran@67657 or any non-empty credential
    if (username.trim().isEmpty || password.trim().isEmpty) {
      throw Exception('Username and password are required');
    }

    if (password.length < 4) {
      throw Exception('Invalid credentials provided');
    }

    // Success response payload
    return UserModel(
      id: 'emp_apache_0921',
      username: username.trim(),
      email: username.contains('@') ? username.trim() : '$username@apache.com',
      displayName: username.split('@').first,
      token: 'jwt_apache_connect_${DateTime.now().millisecondsSinceEpoch}',
    );
  }
}
