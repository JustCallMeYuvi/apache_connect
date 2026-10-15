import '../models/admin_stat_item_model.dart';
import '../../domain/entities/admin_stat_item.dart';

abstract class AdminRemoteDataSource {
  Future<List<AdminStatItemModel>> getAdminStats();
}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  @override
  Future<List<AdminStatItemModel>> getAdminStats() async {
    // Simulated network delay for realistic Clean Architecture behavior
    await Future.delayed(const Duration(milliseconds: 300));

    // Data corresponding exactly to reference screenshots
    return const [
      AdminStatItemModel(
        id: 'users',
        title: 'Users',
        count: 7,
        subtitle: 'Manage',
        iconType: AdminIconType.users,
        route: '/admin/users',
        description: 'Manage system users, accounts, and directory access.',
      ),
      AdminStatItemModel(
        id: 'roles',
        title: 'Roles',
        count: 7,
        subtitle: 'Manage',
        iconType: AdminIconType.roles,
        route: '/admin/roles',
        description: 'Define organizational roles and security permissions.',
      ),
      AdminStatItemModel(
        id: 'factories',
        title: 'Factories',
        count: 3,
        subtitle: 'Manage',
        iconType: AdminIconType.factories,
        route: '/admin/factories',
        description: 'Configure plant locations, operational zones, and production facilities.',
      ),
      AdminStatItemModel(
        id: 'locations',
        title: 'Locations',
        count: 1,
        subtitle: 'Manage',
        iconType: AdminIconType.locations,
        route: '/admin/locations',
        description: 'Manage geographical sites and plant office locations.',
      ),
      AdminStatItemModel(
        id: 'categories',
        title: 'Categories',
        count: 4,
        subtitle: 'Manage',
        iconType: AdminIconType.categories,
        route: '/admin/categories',
        description: 'Manage document classification taxonomy and tags.',
      ),
      AdminStatItemModel(
        id: 'settings',
        title: 'Settings',
        count: null,
        subtitle: 'Manage',
        iconType: AdminIconType.settings,
        route: '/admin/settings',
        description: 'Global system configuration, security policies, and integrations.',
      ),
      AdminStatItemModel(
        id: 'audit_log',
        title: 'Audit log',
        count: 18,
        subtitle: 'Manage',
        iconType: AdminIconType.auditLog,
        route: '/admin/audit-log',
        description: 'Track administrative activity, user logins, and critical audit events.',
      ),
    ];
  }
}
