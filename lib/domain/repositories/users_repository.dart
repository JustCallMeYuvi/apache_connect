import '../../core/network/api_result.dart';
import '../entities/managed_user.dart';

abstract class UsersRepository {
  Future<ApiResult<List<ManagedUser>>> getUsers();
  Future<ApiResult<List<String>>> getFactories();
  Future<ApiResult<List<EmployeeLookup>>> getEmployeesByFactory(String factory);
  Future<ApiResult<ManagedUser>> createUser(ManagedUser user);
  Future<ApiResult<ManagedUser>> updateUser(ManagedUser user);
  Future<ApiResult<ManagedUser>> toggleUserStatus(String barcode, bool newStatus);
  Future<ApiResult<bool>> deleteUser(String barcode);
}