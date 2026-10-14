import '../../core/network/api_result.dart';
import '../repositories/notifications_repository.dart';

class DeleteNotificationUseCase {
  final NotificationsRepository _repository;

  DeleteNotificationUseCase(this._repository);

  Future<ApiResult<void>> execute(String id) async {
    return await _repository.deleteNotification(id);
  }
}
