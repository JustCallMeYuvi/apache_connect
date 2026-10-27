import '../../core/network/api_result.dart';
import '../../domain/entities/managed_user.dart';
import '../../domain/repositories/users_repository.dart';
import '../datasources/users_remote_data_source.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;

  UsersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<ManagedUser>>> getUsers() async {
    final result = await remoteDataSource.getUsers();
    return result.when(
      success: (models) => ApiResult.success(models),
      failure: (message) => ApiResult.failure(message),
    );
  }

  @override
  Future<ApiResult<List<String>>> getFactories() async {
    return await remoteDataSource.getFactories();
  }

  @override
  Future<ApiResult<List<EmployeeLookup>>> getEmployeesByFactory(String factory) async {
    return await remoteDataSource.getEmployeesByFactory(factory);
  }

  @override
  Future<ApiResult<ManagedUser>> createUser(ManagedUser user) async {
    final result = await remoteDataSource.createUser(user);
    return result.when(
      success: (model) => ApiResult.success(model),
      failure: (message) => ApiResult.failure(message),
    );
  }

  @override
  Future<ApiResult<ManagedUser>> updateUser(ManagedUser user) async {
    final result = await remoteDataSource.updateUser(user);
    return result.when(
      success: (model) => ApiResult.success(model),
      failure: (message) => ApiResult.failure(message),
    );
  }

  @override
  Future<ApiResult<ManagedUser>> toggleUserStatus(String barcode, bool newStatus) async {
    final result = await remoteDataSource.toggleUserStatus(barcode, newStatus);
    return result.when(
      success: (model) => ApiResult.success(model),
      failure: (message) => ApiResult.failure(message),
    );
  }

  @override
  Future<ApiResult<bool>> deleteUser(String barcode) async {
    return await remoteDataSource.deleteUser(barcode);
  }
}
