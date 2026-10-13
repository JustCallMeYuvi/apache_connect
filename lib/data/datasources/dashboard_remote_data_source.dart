import '../models/dashboard_data_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardDataModel> fetchDashboardData();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  @override
  Future<DashboardDataModel> fetchDashboardData() async {
    // Simulate brief network latency for Clean Architecture realistic loading state
    await Future.delayed(const Duration(milliseconds: 300));

    // Data payload matches attached desktop and mobile screenshots precisely
    return DashboardDataModel.fromJson(const {
      'profile':  {
        'name': 'Yuvaraj',
        'role': 'Admin',
        'initials': 'Yuvi',
      },
      'stats':  {
        'unread_messages': 5,
        'documents': 3,
        'shared_with_me': 2,
        'notifications': 6,
      },
      'recent_documents':  [
        {
          'id': 'doc_1',
          'name': 'Ops-Review.pptx',
          'extension': 'pptx',
          'version': 'V1.0',
          'date': 'Sep 30',
        },
        {
          'id': 'doc_2',
          'name': 'Budget-Q3.xlsx',
          'extension': 'xlsx',
          'version': 'V1.1',
          'date': 'Sep 18',
        },
        {
          'id': 'doc_3',
          'name': 'Safety-Plan.docx',
          'extension': 'docx',
          'version': 'V1.0',
          'date': 'Jul 10',
        },
      ],
      'recent_messages':  [
        {
          'id': 'msg_1',
          'sender': 'Safety Committee',
          'preview': 'Sounds good.',
          'initials': null,
          'is_group': true,
          'is_online': false,
          'unread_badge': 2,
          'color_hex': 0xFF9A3412, // Rust brown group
        },
        {
          'id': 'msg_2',
          'sender': 'Anita Sharma',
          'preview': 'Thanks for the update!',
          'initials': 'AS',
          'is_group': false,
          'is_online': true, // Green dot indicator
          'unread_badge': 0,
          'color_hex': 0xFF6366F1, // Purple
        },
        {
          'id': 'msg_3',
          'sender': 'Finance Team',
          'preview': 'Sounds good.',
          'initials': null,
          'is_group': true,
          'is_online': false,
          'unread_badge': 3,
          'color_hex': 0xFF0D9488, // Teal group
        },
        {
          'id': 'msg_4',
          'sender': 'Ravi Kumar',
          'preview': 'Can you review the Q3 budget numbers today?',
          'initials': 'RK',
          'is_group': false,
          'is_online': false,
          'unread_badge': 0,
          'color_hex': 0xFF115E59, // Dark teal
        },
      ],
      'notifications':  [
        {
          'id': 'notif_1',
          'sender': 'Suresh Babu',
          'description': 'new message',
        },
        {
          'id': 'notif_2',
          'sender': 'Anita Sharma',
          'description': 'new message',
        },
        {
          'id': 'notif_3',
          'sender': 'Kavya Reddy',
          'description': 'new message',
        },
        {
          'id': 'notif_4',
          'sender': 'Meena Rao',
          'description': 'new message',
        },
      ],
    });
  }
}
