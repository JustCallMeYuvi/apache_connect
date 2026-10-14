import '../../core/network/api_result.dart';
import '../entities/app_notification.dart';
import '../repositories/notifications_repository.dart';

class MarkNotificationReadUseCase {
  final NotificationsRepository _repository;

  MarkNotificationReadUseCase(this._repository);

  Future<ApiResult<AppNotification>> executeRead(String id) async {
    return await _repository.markAsRead(id);
  }

  Future<ApiResult<AppNotification>> executeUnread(String id) async {
    return await _repository.markAsUnread(id);
  }
}
