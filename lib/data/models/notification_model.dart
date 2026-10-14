import '../../domain/entities/app_notification.dart';

/// Data Model representing a notification with JSON serialization support
class NotificationModel extends AppNotification {
  const NotificationModel({
    required super.id,
    required super.sender,
    required super.message,
    required super.detailMessage,
    required super.timestamp,
    required super.formattedDate,
    required super.type,
    super.isRead,
    super.targetRoute,
    super.targetItemName,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      sender: json['sender'] as String,
      message: json['message'] as String,
      detailMessage: json['detailMessage'] as String? ?? json['message'] as String,
      timestamp: json['timestamp'] as String,
      formattedDate: json['formattedDate'] as String? ?? json['timestamp'] as String,
      type: (json['type'] as String?) == 'mention'
          ? NotificationType.mention
          : NotificationType.message,
      isRead: json['isRead'] as bool? ?? false,
      targetRoute: json['targetRoute'] as String?,
      targetItemName: json['targetItemName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'message': message,
      'detailMessage': detailMessage,
      'timestamp': timestamp,
      'formattedDate': formattedDate,
      'type': type == NotificationType.mention ? 'mention' : 'message',
      'isRead': isRead,
      'targetRoute': targetRoute,
      'targetItemName': targetItemName,
    };
  }

  factory NotificationModel.fromEntity(AppNotification entity) {
    return NotificationModel(
      id: entity.id,
      sender: entity.sender,
      message: entity.message,
      detailMessage: entity.detailMessage,
      timestamp: entity.timestamp,
      formattedDate: entity.formattedDate,
      type: entity.type,
      isRead: entity.isRead,
      targetRoute: entity.targetRoute,
      targetItemName: entity.targetItemName,
    );
  }
}
