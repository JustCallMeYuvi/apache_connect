import '../../core/network/api_result.dart';
import '../entities/app_notification.dart';
import '../repositories/notifications_repository.dart';

class GetNotificationsUseCase {
  final NotificationsRepository _repository;

  GetNotificationsUseCase(this._repository);

  Future<ApiResult<List<AppNotification>>> execute() async {
    return await _repository.getNotifications();
  }
}
