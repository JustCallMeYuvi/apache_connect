import '../../core/network/api_result.dart';
import '../entities/app_notification.dart';

/// Clean Architecture Repository contract for Notification management
abstract class NotificationsRepository {
  Future<ApiResult<List<AppNotification>>> getNotifications();
  Future<ApiResult<AppNotification>> markAsRead(String id);
  Future<ApiResult<AppNotification>> markAsUnread(String id);
  Future<ApiResult<void>> markAllAsRead();
  Future<ApiResult<void>> deleteNotification(String id);
}
