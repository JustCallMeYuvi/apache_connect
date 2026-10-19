import 'package:flutter/material.dart';

import '../../core/network/api_result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  // @override
  // Future<ApiResult<User>> login({
  //   required String username,
  //   required String password,
  //   required bool rememberMe,
  // }) async {
  //   try {
  //     final userModel = await remoteDataSource.login(
  //       username: username,
  //       password: password,
  //       rememberMe: rememberMe,
  //     );
  //     return Success(userModel);
  //   } catch (e) {
  //     return Failure(e.toString().replaceAll('Exception: ', ''));
  //   }
  // }
  
@override
Future<ApiResult<User>> login({
  required String username,
  required String password,
  required bool rememberMe,
}) async {
  debugPrint('REPOSITORY DEBUG: login started');
  debugPrint('REPOSITORY DEBUG: username=[$username]');
  debugPrint('REPOSITORY DEBUG: password length=${password.length}');

  try {
    debugPrint('REPOSITORY DEBUG: calling AuthRemoteDataSource');

    final userModel = await remoteDataSource.login(
      username: username,
      password: password,
      rememberMe: rememberMe,
    );

    debugPrint('REPOSITORY DEBUG: remote data source succeeded');

    return Success(userModel);
  } catch (e, stackTrace) {
    debugPrint('REPOSITORY DEBUG: exception=$e');
    debugPrintStack(stackTrace: stackTrace);

    return Failure(
      e.toString().replaceAll('Exception: ', ''),
    );
  }
}


  @override
  Future<void> logout() async {
    // Clear tokens/cache when implemented
  }

  @override
  Future<User?> getCurrentUser() async {
    return null;
  }
}
