// import '../models/user_model.dart';

// abstract class AuthRemoteDataSource {
//   Future<UserModel> login({
//     required String username,
//     required String password,
//     required bool rememberMe,
//   });
// }

// /// Production-ready mock / placeholder datasource with realistic network latency,
// /// easily swappable with http.Client when connected to the ApacheConnect REST backend.
// class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
//   // In a production backend scenario, inject http.Client or Dio
//   // final http.Client client;

//   AuthRemoteDataSourceImpl();

//   @override
//   Future<UserModel> login({
//     required String username,
//     required String password,
//     required bool rememberMe,
//   }) async {
//     // Simulate real network trip
//     await Future.delayed(const Duration(milliseconds: 1200));

//     // Basic authentication simulation
//     // Allows default preview user from screenshot: Imran@67657 or any non-empty credential
//     if (username.trim().isEmpty || password.trim().isEmpty) {
//       throw Exception('Username and password are required');
//     }

//     if (password.length < 4) {
//       throw Exception('Invalid credentials provided');
//     }

//     // Success response payload
//     return UserModel(
//       id: 'emp_apache_0921',
//       username: username.trim(),
//       email: username.contains('@') ? username.trim() : '$username@apache.com',
//       displayName: username.split('@').first,
//       token: 'jwt_apache_connect_${DateTime.now().millisecondsSinceEpoch}',
//     );
//   }
// }

import 'package:apache_connect/core/network/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  AuthRemoteDataSource(Dio instance);

  Future<UserModel> login({
    required String username,
    required String password,
    required bool rememberMe,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    debugPrint('AUTH API: Sending login request');
    debugPrint('AUTH API: URL = ${dio.options.baseUrl}/api/auth/login');
    debugPrint('AUTH API: Username = [$username]');

    try {
      final response = await dio.post<Map<String, dynamic>>(
        // '/api/auth/login',
        ApiEndpoints.login,
        data: {
          'username': username.trim(),
          'password': password,
        },
      );

      final body = response.data ?? <String, dynamic>{};

      debugPrint('AUTH API: Status = ${response.statusCode}');
      debugPrint('AUTH API: Success = ${body['success']}');
      debugPrint('AUTH API: Message = ${body['message']}');

      if (body['success'] != true) {
        throw Exception(
          body['message']?.toString() ?? 'Login failed.',
        );
      }

      final data = body['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('Login response is missing data.');
      }

      final apiUser = data['user'] as Map<String, dynamic>?;
      if (apiUser == null) {
        throw Exception('Login response is missing user details.');
      }

      final token = data['token']?.toString() ?? '';
      if (token.isEmpty) {
        throw Exception('Login response is missing the token.');
      }

      // Map the actual API response into your existing UserModel.
      return UserModel(
        id: apiUser['id'].toString(),
        username: apiUser['username']?.toString() ?? username,
        email: apiUser['username']?.toString() ?? username,
        displayName: apiUser['empName']?.toString() ?? username,
        token: token,
      );
    } on DioException catch (e) {
      debugPrint('AUTH API: HTTP status = ${e.response?.statusCode}');
      debugPrint('AUTH API: Error = ${e.message}');

      final responseBody = e.response?.data;
      if (responseBody is Map && responseBody['message'] != null) {
        throw Exception(responseBody['message'].toString());
      }

      if (e.response == null) {
        throw Exception(
          'Cannot connect to the API. Check the server and network.',
        );
      }

      throw Exception(
        'Login request failed with status ${e.response?.statusCode}.',
      );
    }
  }
}
