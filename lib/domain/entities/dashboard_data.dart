import 'package:equatable/equatable.dart';

/// Clean Architecture Entity representing Dashboard statistics & content
class DashboardData extends Equatable {
  final UserProfile profile;
  final SummaryStats stats;
  final List<DocumentItem> recentDocuments;
  final List<MessageItem> recentMessages;
  final List<NotificationItem> notifications;

  const DashboardData({
    required this.profile,
    required this.stats,
    required this.recentDocuments,
    required this.recentMessages,
    required this.notifications,
  });

  @override
  List<Object?> get props => [
        profile,
        stats,
        recentDocuments,
        recentMessages,
        notifications,
      ];
}

class UserProfile extends Equatable {
  final String name;
  final String role;
  final String initials;

  const UserProfile({
    required this.name,
    required this.role,
    required this.initials,
  });

  @override
  List<Object?> get props => [name, role, initials];
}

class SummaryStats extends Equatable {
  final int unreadMessagesCount;
  final int documentsCount;
  final int sharedWithMeCount;
  final int notificationsCount;

  const SummaryStats({
    required this.unreadMessagesCount,
    required this.documentsCount,
    required this.sharedWithMeCount,
    required this.notificationsCount,
  });

  @override
  List<Object?> get props => [
        unreadMessagesCount,
        documentsCount,
        sharedWithMeCount,
        notificationsCount,
      ];
}

class DocumentItem extends Equatable {
  final String id;
  final String name;
  final String extension; // 'pptx', 'xlsx', 'docx'
  final String version;
  final String date;

  const DocumentItem({
    required this.id,
    required this.name,
    required this.extension,
    required this.version,
    required this.date,
  });

  @override
  List<Object?> get props => [id, name, extension, version, date];
}

class MessageItem extends Equatable {
  final String id;
  final String sender;
  final String preview;
  final String? initials;
  final bool isGroup;
  final bool isOnline;
  final int unreadBadge;
  final int colorHex;

  const MessageItem({
    required this.id,
    required this.sender,
    required this.preview,
    this.initials,
    this.isGroup = false,
    this.isOnline = false,
    this.unreadBadge = 0,
    required this.colorHex,
  });

  @override
  List<Object?> get props => [
        id,
        sender,
        preview,
        initials,
        isGroup,
        isOnline,
        unreadBadge,
        colorHex,
      ];
}

class NotificationItem extends Equatable {
  final String id;
  final String sender;
  final String description;

  const NotificationItem({
    required this.id,
    required this.sender,
    required this.description,
  });

  @override
  List<Object?> get props => [id, sender, description];
}
