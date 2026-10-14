import '../../core/network/api_result.dart';
import '../repositories/notifications_repository.dart';

class MarkAllNotificationsReadUseCase {
  final NotificationsRepository _repository;

  MarkAllNotificationsReadUseCase(this._repository);

  Future<ApiResult<void>> execute() async {
    return await _repository.markAllAsRead();
  }
}
