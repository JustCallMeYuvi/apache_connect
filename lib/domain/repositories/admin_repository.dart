import '../../core/network/api_result.dart';
import '../entities/admin_stat_item.dart';

/// Contract for Admin Dashboard statistics and modules data operations
abstract class AdminRepository {
  Future<ApiResult<List<AdminStatItem>>> getAdminStats();
}
