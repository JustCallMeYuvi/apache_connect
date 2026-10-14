import 'package:equatable/equatable.dart';
import '../../../domain/entities/app_notification.dart';

enum NotificationsStatus { initial, loading, loaded, error }

class NotificationsState extends Equatable {
  final NotificationsStatus status;
  final List<AppNotification> notifications;
  final String? selectedNotificationId;
  final String? errorMessage;
  final String? lastSuccessAction;

  const NotificationsState({
    this.status = NotificationsStatus.initial,
    this.notifications = const [],
    this.selectedNotificationId,
    this.errorMessage,
    this.lastSuccessAction,
  });

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  AppNotification? get selectedNotification {
    if (selectedNotificationId == null) return null;
    try {
      return notifications.firstWhere((n) => n.id == selectedNotificationId);
    } catch (_) {
      return null;
    }
  }

  bool get isLoading => status == NotificationsStatus.loading;

  NotificationsState copyWith({
    NotificationsStatus? status,
    List<AppNotification>? notifications,
    String? selectedNotificationId,
    bool clearSelectedNotification = false,
    String? errorMessage,
    String? lastSuccessAction,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      selectedNotificationId: clearSelectedNotification
          ? null
          : (selectedNotificationId ?? this.selectedNotificationId),
      errorMessage: errorMessage,
      lastSuccessAction: lastSuccessAction,
    );
  }

  @override
  List<Object?> get props => [
        status,
        notifications,
        selectedNotificationId,
        errorMessage,
        lastSuccessAction,
      ];
}
