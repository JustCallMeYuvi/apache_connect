import '../../core/network/api_result.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_remote_data_source.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource remoteDataSource;

  NotificationsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<AppNotification>>> getNotifications() async {
    try {
      final result = await remoteDataSource.getNotifications();
      return Success(result);
    } catch (e) {
      return Failure('Failed to fetch notifications: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<AppNotification>> markAsRead(String id) async {
    try {
      final result = await remoteDataSource.markAsRead(id);
      return Success(result);
    } catch (e) {
      return Failure('Failed to mark notification as read: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<AppNotification>> markAsUnread(String id) async {
    try {
      final result = await remoteDataSource.markAsUnread(id);
      return Success(result);
    } catch (e) {
      return Failure('Failed to mark notification as unread: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<void>> markAllAsRead() async {
    try {
      await remoteDataSource.markAllAsRead();
      return const Success(null);
    } catch (e) {
      return Failure('Failed to mark all as read: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<void>> deleteNotification(String id) async {
    try {
      await remoteDataSource.deleteNotification(id);
      return const Success(null);
    } catch (e) {
      return Failure('Failed to delete notification: ${e.toString()}');
    }
  }
}
