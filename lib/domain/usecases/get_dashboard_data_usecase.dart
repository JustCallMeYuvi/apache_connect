import '../../core/network/api_result.dart';
import '../entities/dashboard_data.dart';
import '../repositories/dashboard_repository.dart';

/// Clean Architecture Use Case to fetch dashboard metrics and recent activity
class GetDashboardDataUseCase {
  final DashboardRepository _repository;

  GetDashboardDataUseCase(this._repository);

  Future<ApiResult<DashboardData>> execute() async {
    return await _repository.getDashboardData();
  }
}
