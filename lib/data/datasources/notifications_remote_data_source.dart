import '../../domain/entities/app_notification.dart';
import '../../routes/app_routes.dart';
import '../models/notification_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<NotificationModel> markAsRead(String id);
  Future<NotificationModel> markAsUnread(String id);
  Future<void> markAllAsRead();
  Future<void> deleteNotification(String id);
}

class NotificationsRemoteDataSourceImpl implements NotificationsRemoteDataSource {
  // In-memory data store matching reference screenshots
  final List<NotificationModel> _notifications = [
    const NotificationModel(
      id: 'notif-1',
      sender: 'Anita Sharma',
      message: 'Anita Sharma mentioned you on “Budget-Q3.xlsx”',
      detailMessage: 'Anita Sharma mentioned you on “Budget-Q3.xlsx” in Financial Planning.',
      timestamp: '09:32 AM',
      formattedDate: 'Oct 14, 2026, 09:32 AM',
      type: NotificationType.mention,
      isRead: false,
      targetRoute: AppRoutes.documents,
      targetItemName: 'Budget-Q3.xlsx',
    ),
    const NotificationModel(
      id: 'notif-2',
      sender: 'Anita Sharma',
      message: 'Anita Sharma: new message',
      detailMessage: 'Anita Sharma sent a new message: "Please review the updated project timelines before our sync."',
      timestamp: '09:31 AM',
      formattedDate: 'Oct 14, 2026, 09:31 AM',
      type: NotificationType.message,
      isRead: false,
      targetRoute: AppRoutes.messages,
      targetItemName: 'Anita Sharma',
    ),
    const NotificationModel(
      id: 'notif-3',
      sender: 'Ravi Kumar',
      message: 'Ravi Kumar mentioned you on “Budget-Q3.xlsx”',
      detailMessage: 'Ravi Kumar mentioned you on “Budget-Q3.xlsx”',
      timestamp: '09:30 AM',
      formattedDate: 'Oct 14, 2026, 09:30 AM',
      type: NotificationType.mention,
      isRead: true,
      targetRoute: AppRoutes.documents,
      targetItemName: 'Budget-Q3.xlsx',
    ),
    const NotificationModel(
      id: 'notif-4',
      sender: 'Ravi Kumar',
      message: 'Ravi Kumar: new message',
      detailMessage: 'Ravi Kumar: "Sharing the latest equipment log sheet for review."',
      timestamp: '09:29 AM',
      formattedDate: 'Oct 14, 2026, 09:29 AM',
      type: NotificationType.message,
      isRead: true,
      targetRoute: AppRoutes.messages,
      targetItemName: 'Ravi Kumar',
    ),
    const NotificationModel(
      id: 'notif-5',
      sender: 'Kavya Reddy',
      message: 'Kavya Reddy: new message',
      detailMessage: 'Kavya Reddy: "Are we still on schedule for the afternoon walkthrough?"',
      timestamp: '09:27 AM',
      formattedDate: 'Oct 14, 2026, 09:27 AM',
      type: NotificationType.message,
      isRead: true,
      targetRoute: AppRoutes.messages,
      targetItemName: 'Kavya Reddy',
    ),
    const NotificationModel(
      id: 'notif-6',
      sender: 'Ravi Kumar',
      message: 'Ravi Kumar: new message',
      detailMessage: 'Ravi Kumar: "Added comments to the invoice draft."',
      timestamp: '09:26 AM',
      formattedDate: 'Oct 14, 2026, 09:26 AM',
      type: NotificationType.message,
      isRead: true,
      targetRoute: AppRoutes.messages,
      targetItemName: 'Ravi Kumar',
    ),
    const NotificationModel(
      id: 'notif-7',
      sender: 'Ravi Kumar',
      message: 'Ravi Kumar: new message',
      detailMessage: 'Ravi Kumar: "Can you approve the vendor request when free?"',
      timestamp: '09:26 AM',
      formattedDate: 'Oct 14, 2026, 09:26 AM',
      type: NotificationType.message,
      isRead: true,
      targetRoute: AppRoutes.messages,
      targetItemName: 'Ravi Kumar',
    ),
    const NotificationModel(
      id: 'notif-8',
      sender: 'Kavya Reddy',
      message: 'Kavya Reddy: new message',
      detailMessage: 'Kavya Reddy: "Uploaded the preliminary inspection sheet."',
      timestamp: '09:25 AM',
      formattedDate: 'Oct 14, 2026, 09:25 AM',
      type: NotificationType.message,
      isRead: true,
      targetRoute: AppRoutes.messages,
      targetItemName: 'Kavya Reddy',
    ),
    const NotificationModel(
      id: 'notif-9',
      sender: 'Ravi Kumar',
      message: 'Ravi Kumar mentioned you on “Budget-Q3.xlsx”',
      detailMessage: 'Ravi Kumar mentioned you on “Budget-Q3.xlsx” in Section 4.',
      timestamp: '09:24 AM',
      formattedDate: 'Oct 14, 2026, 09:24 AM',
      type: NotificationType.mention,
      isRead: true,
      targetRoute: AppRoutes.documents,
      targetItemName: 'Budget-Q3.xlsx',
    ),
    const NotificationModel(
      id: 'notif-10',
      sender: 'Priya Nair',
      message: 'Priya Nair: new message',
      detailMessage: 'Priya Nair: "Sent you the monthly compliance certificates."',
      timestamp: '09:23 AM',
      formattedDate: 'Oct 14, 2026, 09:23 AM',
      type: NotificationType.message,
      isRead: true,
      targetRoute: AppRoutes.messages,
      targetItemName: 'Priya Nair',
    ),
    const NotificationModel(
      id: 'notif-11',
      sender: 'Kavya Reddy',
      message: 'Kavya Reddy: new message',
      detailMessage: 'Kavya Reddy: "Confirmed the meeting room at 2:00 PM."',
      timestamp: '09:22 AM',
      formattedDate: 'Oct 14, 2026, 09:22 AM',
      type: NotificationType.message,
      isRead: true,
      targetRoute: AppRoutes.messages,
      targetItemName: 'Kavya Reddy',
    ),
    const NotificationModel(
      id: 'notif-12',
      sender: 'Meena Rao',
      message: 'Meena Rao: new message',
      detailMessage: 'Meena Rao: "Safety audit report has been submitted to the portal."',
      timestamp: '09:21 AM',
      formattedDate: 'Oct 14, 2026, 09:21 AM',
      type: NotificationType.message,
      isRead: true,
      targetRoute: AppRoutes.messages,
      targetItemName: 'Meena Rao',
    ),
  ];

  @override
  Future<List<NotificationModel>> getNotifications() async {
    // Simulate brief network latency
    await Future.delayed(const Duration(milliseconds: 150));
    return List.from(_notifications);
  }

  @override
  Future<NotificationModel> markAsRead(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      final current = _notifications[index];
      final updated = NotificationModel(
        id: current.id,
        sender: current.sender,
        message: current.message,
        detailMessage: current.detailMessage,
        timestamp: current.timestamp,
        formattedDate: current.formattedDate,
        type: current.type,
        isRead: true,
        targetRoute: current.targetRoute,
        targetItemName: current.targetItemName,
      );
      _notifications[index] = updated;
      return updated;
    }
    throw Exception('Notification not found: $id');
  }

  @override
  Future<NotificationModel> markAsUnread(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      final current = _notifications[index];
      final updated = NotificationModel(
        id: current.id,
        sender: current.sender,
        message: current.message,
        detailMessage: current.detailMessage,
        timestamp: current.timestamp,
        formattedDate: current.formattedDate,
        type: current.type,
        isRead: false,
        targetRoute: current.targetRoute,
        targetItemName: current.targetItemName,
      );
      _notifications[index] = updated;
      return updated;
    }
    throw Exception('Notification not found: $id');
  }

  @override
  Future<void> markAllAsRead() async {
    await Future.delayed(const Duration(milliseconds: 100));
    for (int i = 0; i < _notifications.length; i++) {
      final current = _notifications[i];
      if (!current.isRead) {
        _notifications[i] = NotificationModel(
          id: current.id,
          sender: current.sender,
          message: current.message,
          detailMessage: current.detailMessage,
          timestamp: current.timestamp,
          formattedDate: current.formattedDate,
          type: current.type,
          isRead: true,
          targetRoute: current.targetRoute,
          targetItemName: current.targetItemName,
        );
      }
    }
  }

  @override
  Future<void> deleteNotification(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _notifications.removeWhere((n) => n.id == id);
  }
}
