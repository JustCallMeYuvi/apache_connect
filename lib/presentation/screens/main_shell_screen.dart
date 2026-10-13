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

  late final List<Widget> _screens = [
    DashboardScreen(onNavItemSelected: _onNavItemSelected),
    MessagesScreen(onNavItemSelected: _onNavItemSelected),
    DocumentsScreen(onNavItemSelected: _onNavItemSelected),
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
    return IndexedStack(
      index: _selectedIndex,
      children: _screens,
    );
  }
}
