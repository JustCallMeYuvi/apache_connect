// import 'package:flutter/material.dart';

// import 'dashboard_screen.dart';
// import 'messages_screen.dart';
// import 'documents_screen.dart';

// class MainShellScreen extends StatefulWidget {
//   const MainShellScreen({super.key});

//   @override
//   State<MainShellScreen> createState() => _MainShellScreenState();
// }

// class _MainShellScreenState extends State<MainShellScreen> {
//   int _selectedIndex = 0;

//   late final List<Widget> _screens = [
//     DashboardScreen(
//       onNavItemSelected: _onNavItemSelected,
//     ),
//     MessagesScreen(
//       onNavItemSelected: _onNavItemSelected,
//     ),
//     DocumentsScreen(
//       onNavItemSelected: _onNavItemSelected,
//     ),
//   ];

//   void _onNavItemSelected(int index) {
//     if (index < 0 || index >= _screens.length) return;
//     if (index == _selectedIndex) return;

//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return IndexedStack(
//       index: _selectedIndex,
//       children: _screens,
//     );
//   }
// }

// 22-10-2026
import 'package:apache_connect/presentation/screens/admin_dashboard_screen.dart';
import 'package:apache_connect/presentation/screens/notifications_screen.dart';
import 'package:apache_connect/presentation/screens/profile_screen.dart';
import 'package:apache_connect/presentation/screens/users_screen.dart';
import 'package:apache_connect/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'messages_screen.dart';
import 'documents_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  late final List<Widget> _screens = [
    DashboardScreen(onNavItemSelected: _onNavItemSelected),
    MessagesScreen(onNavItemSelected: _onNavItemSelected),
    DocumentsScreen(onNavItemSelected: _onNavItemSelected),
    NotificationsScreen(onNavItemSelected: _onNavItemSelected),
    AdminDashboardScreen(onNavItemSelected: _onNavItemSelected), // 4
    UsersScreen(onNavItemSelected: _onNavItemSelected), // 5
    ProfileScreen(onNavItemSelected: _onNavItemSelected),
  ];

  void _onNavItemSelected(int index) {
    if (index < 0 || index >= _screens.length) return;
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const titles = [
      'Dashboard',
      'Messages',
      'Documents',
      'Notifications',
      'Admin Dashboard',
      'Users',
      'My Profile',
    ];
    // return IndexedStack(
    //   index: _selectedIndex,
    //   children: _screens,
    // );
    return AppScaffold(
      title: titles[_selectedIndex],
      activeNavIndex: _selectedIndex,
      isDarkMode: _isDarkMode,
      onThemeToggle: _toggleTheme,
      onNavItemSelected: _onNavItemSelected,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
    );
  }
}
