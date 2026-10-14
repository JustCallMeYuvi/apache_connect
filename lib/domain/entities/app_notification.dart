import 'package:equatable/equatable.dart';

/// Type of notification in ApacheConnect
enum NotificationType {
  mention,
  message,
}

/// Pure Domain Entity representing a Notification alert in ApacheConnect
class AppNotification extends Equatable {
  final String id;
  final String sender;
  final String message;
  final String detailMessage;
  final String timestamp;
  final String formattedDate;
  final NotificationType type;
  final bool isRead;
  final String? targetRoute;
  final String? targetItemName;

  const AppNotification({
    required this.id,
    required this.sender,
    required this.message,
    required this.detailMessage,
    required this.timestamp,
    required this.formattedDate,
    required this.type,
    this.isRead = false,
    this.targetRoute,
    this.targetItemName,
  });

  AppNotification copyWith({
    String? id,
    String? sender,
    String? message,
    String? detailMessage,
    String? timestamp,
    String? formattedDate,
    NotificationType? type,
    bool? isRead,
    String? targetRoute,
    String? targetItemName,
  }) {
    return AppNotification(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      message: message ?? this.message,
      detailMessage: detailMessage ?? this.detailMessage,
      timestamp: timestamp ?? this.timestamp,
      formattedDate: formattedDate ?? this.formattedDate,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      targetRoute: targetRoute ?? this.targetRoute,
      targetItemName: targetItemName ?? this.targetItemName,
    );
  }

  @override
  List<Object?> get props => [
        id,
        sender,
        message,
        detailMessage,
        timestamp,
        formattedDate,
        type,
        isRead,
        targetRoute,
        targetItemName,
      ];
}
