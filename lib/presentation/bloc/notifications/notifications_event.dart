import 'package:equatable/equatable.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotificationsEvent extends NotificationsEvent {
  const LoadNotificationsEvent();
}

class SelectNotificationEvent extends NotificationsEvent {
  final String id;
  const SelectNotificationEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleNotificationReadStatusEvent extends NotificationsEvent {
  final String id;
  const ToggleNotificationReadStatusEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class MarkNotificationReadEvent extends NotificationsEvent {
  final String id;
  const MarkNotificationReadEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class MarkNotificationUnreadEvent extends NotificationsEvent {
  final String id;
  const MarkNotificationUnreadEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class MarkAllNotificationsReadEvent extends NotificationsEvent {
  const MarkAllNotificationsReadEvent();
}

class DeleteNotificationEvent extends NotificationsEvent {
  final String id;
  const DeleteNotificationEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ClearSelectedNotificationEvent extends NotificationsEvent {
  const ClearSelectedNotificationEvent();
}
