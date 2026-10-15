import '../../domain/entities/admin_stat_item.dart';

class AdminStatItemModel extends AdminStatItem {
  const AdminStatItemModel({
    required super.id,
    required super.title,
    super.count,
    super.subtitle = 'Manage',
    required super.iconType,
    super.route,
    super.description = '',
  });

  factory AdminStatItemModel.fromJson(Map<String, dynamic> json) {
    return AdminStatItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      count: json['count'] as int?,
      subtitle: json['subtitle'] as String? ?? 'Manage',
      iconType: _parseIconType(json['iconType'] as String?),
      route: json['route'] as String?,
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'count': count,
      'subtitle': subtitle,
      'iconType': iconType.name,
      'route': route,
      'description': description,
    };
  }

  static AdminIconType _parseIconType(String? type) {
    switch (type) {
      case 'users':
        return AdminIconType.users;
      case 'roles':
        return AdminIconType.roles;
      case 'factories':
        return AdminIconType.factories;
      case 'locations':
        return AdminIconType.locations;
      case 'categories':
        return AdminIconType.categories;
      case 'settings':
        return AdminIconType.settings;
      case 'auditLog':
      case 'audit_log':
        return AdminIconType.auditLog;
      default:
        return AdminIconType.users;
    }
  }
}
