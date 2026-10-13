import '../../core/network/api_result.dart';
import '../entities/dashboard_data.dart';

/// Abstract contract for dashboard repository in domain layer
abstract class DashboardRepository {
  Future<ApiResult<DashboardData>> getDashboardData();
}
