import '../../core/network/api_result.dart';
import '../entities/admin_stat_item.dart';
import '../repositories/admin_repository.dart';

/// Use case to fetch administration modules and their counts
class GetAdminStatsUseCase {
  final AdminRepository _repository;

  const GetAdminStatsUseCase(this._repository);

  Future<ApiResult<List<AdminStatItem>>> execute() async {
    return await _repository.getAdminStats();
  }
}
