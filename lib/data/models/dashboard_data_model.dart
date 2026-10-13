import '../../domain/entities/dashboard_data.dart';

class DashboardDataModel extends DashboardData {
  const DashboardDataModel({
    required super.profile,
    required super.stats,
    required super.recentDocuments,
    required super.recentMessages,
    required super.notifications,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) {
    return DashboardDataModel(
      profile: UserProfile(
        name: json['profile']?['name'] ?? 'Syed Imran',
        role: json['profile']?['role'] ?? 'Admin',
        initials: json['profile']?['initials'] ?? 'SI',
      ),
      stats: SummaryStats(
        unreadMessagesCount: json['stats']?['unread_messages'] ?? 5,
        documentsCount: json['stats']?['documents'] ?? 3,
        sharedWithMeCount: json['stats']?['shared_with_me'] ?? 2,
        notificationsCount: json['stats']?['notifications'] ?? 6,
      ),
      recentDocuments: (json['recent_documents'] as List<dynamic>? ?? []).map((e) {
        return DocumentItem(
          id: e['id'] ?? '',
          name: e['name'] ?? '',
          extension: e['extension'] ?? 'pptx',
          version: e['version'] ?? 'V1.0',
          date: e['date'] ?? '',
        );
      }).toList(),
      recentMessages: (json['recent_messages'] as List<dynamic>? ?? []).map((e) {
        return MessageItem(
          id: e['id'] ?? '',
          sender: e['sender'] ?? '',
          preview: e['preview'] ?? '',
          initials: e['initials'],
          isGroup: e['is_group'] ?? false,
          isOnline: e['is_online'] ?? false,
          unreadBadge: e['unread_badge'] ?? 0,
          colorHex: e['color_hex'] ?? 0xFF9A3412,
        );
      }).toList(),
      notifications: (json['notifications'] as List<dynamic>? ?? []).map((e) {
        return NotificationItem(
          id: e['id'] ?? '',
          sender: e['sender'] ?? '',
          description: e['description'] ?? '',
        );
      }).toList(),
    );
  }
}
