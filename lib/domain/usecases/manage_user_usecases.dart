import '../../core/network/api_result.dart';
import '../entities/managed_user.dart';
import '../repositories/users_repository.dart';

class GetUsersUseCase {
  final UsersRepository repository;

  GetUsersUseCase(this.repository);

  Future<ApiResult<List<ManagedUser>>> call() async {
    return await repository.getUsers();
  }
}

class CreateUserUseCase {
  final UsersRepository repository;

  CreateUserUseCase(this.repository);

  Future<ApiResult<ManagedUser>> call(ManagedUser user) async {
    return await repository.createUser(user);
  }
}

class UpdateUserUseCase {
  final UsersRepository repository;

  UpdateUserUseCase(this.repository);

  Future<ApiResult<ManagedUser>> call(ManagedUser user) async {
    return await repository.updateUser(user);
  }
}

class ToggleUserStatusUseCase {
  final UsersRepository repository;

  ToggleUserStatusUseCase(this.repository);

  Future<ApiResult<ManagedUser>> call(String barcode, bool newStatus) async {
    return await repository.toggleUserStatus(barcode, newStatus);
  }
}

class DeleteUserUseCase {
  final UsersRepository repository;

  DeleteUserUseCase(this.repository);

  Future<ApiResult<bool>> call(String barcode) async {
    return await repository.deleteUser(barcode);
  }
}

class GetFactoriesUseCase {
  final UsersRepository repository;

  GetFactoriesUseCase(this.repository);

  Future<ApiResult<List<String>>> call() async {
    return await repository.getFactories();
  }
}

class GetEmployeesByFactoryUseCase {
  final UsersRepository repository;

  GetEmployeesByFactoryUseCase(this.repository);

  Future<ApiResult<List<EmployeeLookup>>> call(String factory) async {
    return await repository.getEmployeesByFactory(factory);
  }
}
