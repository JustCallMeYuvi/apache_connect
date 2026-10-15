import 'package:equatable/equatable.dart';

/// Available icon types for Administration dashboard cards
enum AdminIconType {
  users,
  roles,
  factories,
  locations,
  categories,
  settings,
  auditLog,
}

/// Pure Domain Entity representing an Administration Card/Module in ApacheConnect
class AdminStatItem extends Equatable {
  final String id;
  final String title;
  final int? count;
  final String subtitle;
  final AdminIconType iconType;
  final String? route;
  final String description;

  const AdminStatItem({
    required this.id,
    required this.title,
    this.count,
    this.subtitle = 'Manage',
    required this.iconType,
    this.route,
    this.description = '',
  });

  /// Formatted display title (e.g. "Users (7)" or "Settings")
  String get displayTitle {
    if (count != null) {
      return '$title ($count)';
    }
    return title;
  }

  AdminStatItem copyWith({
    String? id,
    String? title,
    int? count,
    String? subtitle,
    AdminIconType? iconType,
    String? route,
    String? description,
  }) {
    return AdminStatItem(
      id: id ?? this.id,
      title: title ?? this.title,
      count: count ?? this.count,
      subtitle: subtitle ?? this.subtitle,
      iconType: iconType ?? this.iconType,
      route: route ?? this.route,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        count,
        subtitle,
        iconType,
        route,
        description,
      ];
}
