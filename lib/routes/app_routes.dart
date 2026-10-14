import 'package:apache_connect/presentation/screens/dashboard_screen.dart';
import 'package:apache_connect/presentation/screens/documents_screen.dart';
import 'package:apache_connect/presentation/screens/main_shell_screen.dart';
import 'package:apache_connect/presentation/screens/messages_screen.dart';
import 'package:apache_connect/presentation/screens/notifications_screen.dart';
import 'package:flutter/material.dart';
import '../presentation/screens/login_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String dashboard = '/dash';
  static const String messages = '/messages';
  static const String documents = '/documents';
  static const String main = '/main';
  static const String notifications = '/notifications';

  static Map<String, WidgetBuilder> get routes => {
        login: (context) => const LoginScreen(),
        dashboard: (context) => const DashboardScreen(),
        messages: (context) => const MessagesScreen(),
        documents: (context) => const DocumentsScreen(),
        main: (context) => const MainShellScreen(),
        notifications: (context) => const NotificationsScreen(),
      };
}
