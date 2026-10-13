import '../../core/network/api_result.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<DashboardData>> getDashboardData() async {
    try {
      final data = await remoteDataSource.fetchDashboardData();
      return Success(data);
    } catch (e) {
      return Failure(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
