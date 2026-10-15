import '../../core/network/api_result.dart';
import '../../domain/entities/admin_stat_item.dart';
import '../../domain/repositories/admin_repository.dart';
import '../datasources/admin_remote_data_source.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource _remoteDataSource;

  const AdminRepositoryImpl({
    required AdminRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<ApiResult<List<AdminStatItem>>> getAdminStats() async {
    try {
      final items = await _remoteDataSource.getAdminStats();
      return Success(items);
    } catch (e) {
      return Failure('Failed to load admin statistics: ${e.toString()}');
    }
  }
}
