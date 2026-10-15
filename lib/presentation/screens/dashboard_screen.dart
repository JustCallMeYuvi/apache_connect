// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../core/constants/app_colors.dart';
// import '../../core/constants/app_strings.dart';
// import '../../domain/entities/dashboard_data.dart';
// import '../../routes/app_routes.dart';
// import '../bloc/dashboard/dashboard_bloc.dart';
// import '../bloc/dashboard/dashboard_event.dart';
// import '../bloc/dashboard/dashboard_state.dart';
// import '../widgets/dashboard_bottom_nav.dart';
// import '../widgets/dashboard_content_cards.dart';
// import '../widgets/dashboard_sidebar.dart';
// import '../widgets/dashboard_summary_card.dart';
// import '../widgets/dashboard_top_bar.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     context.read<DashboardBloc>().add(const LoadDashboardData());
//   }

//   void _handleQuickAction(BuildContext context, String actionName) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         backgroundColor: const Color(0xFF1E293B),
//         title: Text(
//           actionName,
//           style:
//               const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         content: Text(
//           'Action "$actionName" has been triggered. Module connection will be wired in next phase.',
//           style: const TextStyle(color: AppColors.textSecondary),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(ctx).pop(),
//             child: const Text('OK',
//                 style: TextStyle(color: AppColors.primaryOrange)),
//           ),
//         ],
//       ),
//     );
//   }

//   void _handleSignOut(BuildContext context) {
//     Navigator.of(context).pushReplacementNamed(AppRoutes.login);
//   }

//   void _navigateTo(BuildContext context, String route) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!context.mounted) return;

//       Navigator.of(context).pushReplacementNamed(route);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isMobile = size.width < 960;

//     return BlocConsumer<DashboardBloc, DashboardState>(
//       listener: (context, state) {
//         if (state.lastTriggeredAction != null) {
//           _handleQuickAction(context, state.lastTriggeredAction!);
//         }
//       },
//       builder: (context, state) {
//         final data = state.data;
//         final isDarkMode = state.isDarkMode;

//         if (state.isLoading && data == null) {
//           return const Scaffold(
//             backgroundColor: AppColors.dashboardBg,
//             body: Center(
//               child: CircularProgressIndicator(color: AppColors.primaryOrange),
//             ),
//           );
//         }

//         // Fallback default dataset if data is loading for instant responsive preview
//         final stats = data?.stats ??
//             const SummaryStats(
//               unreadMessagesCount: 5,
//               documentsCount: 3,
//               sharedWithMeCount: 2,
//               notificationsCount: 6,
//             );
//         final recentDocs = data?.recentDocuments ?? [];
//         final recentMsgs = data?.recentMessages ?? [];
//         final notifs = data?.notifications ?? [];
//         // final userName =
//         //     data?.profile.name.split(' ').first ?? AppStrings.defaultUserName;
//         const userName = AppStrings.defaultUserName;

//         return SafeArea(
//           child: Scaffold(
//             key: _scaffoldKey,
//             backgroundColor:
//                 isDarkMode ? AppColors.dashboardDarkBg : AppColors.dashboardBg,
//             drawer: isMobile
//                 ? Drawer(
//                     child: DashboardSidebar(
//                       selectedIndex: state.selectedSidebarIndex,
//                       onItemSelected: (idx) {
//                         context
//                             .read<DashboardBloc>()
//                             .add(SelectSidebarItem(idx));
//                         Navigator.of(context).pop();
//                       },
//                       onSignOut: () => _handleSignOut(context),
//                     ),
//                   )
//                 : null,
//             bottomNavigationBar: isMobile
//                 ? DashboardBottomNav(
//                     selectedIndex: state.selectedBottomNavIndex,
//                     onIndexChanged: (idx) {
//                       switch (idx) {
//                         case 0:
//                           // Already on Dashboard.
//                           context
//                               .read<DashboardBloc>()
//                               .add(SelectBottomNavIndex(idx));
//                           break;

//                         case 1:
//                           // Navigator.of(context).pushReplacementNamed(
//                           //   AppRoutes.messages,
//                           // );
//                           _navigateTo(context, AppRoutes.messages);
//                           break;

//                         case 2:
//                           // Navigator.of(context).pushReplacementNamed(
//                           //   AppRoutes.documents,
//                           // );
//                           _navigateTo(context, AppRoutes.documents);
//                           break;

//                         case 3:
//                         
//                           break;

//                         case 4:
//                           
//                           break;
//                       }
//                     },
//                     isDarkMode: isDarkMode,
//                   )
//                 : null,
//             body: Row(
//               children: [
//                 // Desktop Fixed Sidebar
//                 if (!isMobile)
//                   DashboardSidebar(
//                     selectedIndex: state.selectedSidebarIndex,
//                     onItemSelected: (idx) {
//                       Navigator.of(context).pop(); // Close drawer first
//                       if (idx == 1) {
//                         Navigator.of(context).pushReplacementNamed(
//                           AppRoutes.messages,
//                         );
//                       } else if (idx == 2) {
//                         Navigator.of(context).pushReplacementNamed(
//                           AppRoutes.documents,
//                         );
//                       } else {
//                         context
//                             .read<DashboardBloc>()
//                             .add(SelectSidebarItem(idx));
//                       }
//                     },
//                     onSignOut: () => _handleSignOut(context),
//                   ),

//                 // Main Content Canvas
//                 Expanded(
//                   child: Column(
//                     children: [
//                       // Top App Bar
//                       DashboardTopBar(
//                         isMobile: isMobile,
//                         isDarkMode: isDarkMode,
//                         onMenuPressed: () {
//                           if (isMobile) {
//                             _scaffoldKey.currentState?.openDrawer();
//                           }
//                         },
//                         onThemeToggle: () {
//                           context
//                               .read<DashboardBloc>()
//                               .add(const ToggleDashboardTheme());
//                         },
//                         onNotificationPressed: () {
//                           _handleQuickAction(
//                               context, 'Notifications Panel (6 Unread)');
//                         },
//                         onProfilePressed: () {
//                           _handleQuickAction(context, 'Profile: Yuvi (Admin)');
//                         },
//                       ),

//                       // Scrollable Dashboard Body
//                       Expanded(
//                         child: SingleChildScrollView(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: isMobile ? 16 : 28,
//                             vertical: isMobile ? 18 : 24,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Greeting Header: "Good morning, Yuvi 👋"
//                               Row(
//                                 children: [
//                                   Text(
//                                     '${AppStrings.greetingPrefix} $userName',
//                                     style: TextStyle(
//                                       color: isDarkMode
//                                           ? Colors.white
//                                           : AppColors.textDark,
//                                       fontSize: isMobile ? 22 : 28,
//                                       fontWeight: FontWeight.w800,
//                                       letterSpacing: -0.5,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   const Text('👋',
//                                       style: TextStyle(fontSize: 24)),
//                                 ],
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 AppStrings.greetingSubtitle,
//                                 style: TextStyle(
//                                   color: isDarkMode
//                                       ? const Color(0xFF94A3B8)
//                                       : AppColors.textGray,
//                                   fontSize: isMobile ? 13 : 14.5,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),

//                               const SizedBox(height: 24),

//                               // Four Summary Cards:
//                               // Mobile: 2-column grid. Desktop: 4 horizontal columns.
//                               if (isMobile)
//                                 _buildMobileSummaryGrid(stats, isDarkMode)
//                               else
//                                 _buildDesktopSummaryRow(stats, isDarkMode),

//                               const SizedBox(height: 24),

//                               // Middle Content Cards:
//                               // Mobile: Stacked vertically. Desktop: 3 horizontal columns.
//                               if (isMobile)
//                                 Column(
//                                   children: [
//                                     RecentDocumentsCard(
//                                       documents: recentDocs,
//                                       isDarkMode: isDarkMode,
//                                       onDocumentTap: (doc) =>
//                                           _handleQuickAction(
//                                               context, 'Opening ${doc.name}'),
//                                     ),
//                                     const SizedBox(height: 18),
//                                     RecentMessagesCard(
//                                       messages: recentMsgs,
//                                       isDarkMode: isDarkMode,
//                                       onMessageTap: (msg) => _handleQuickAction(
//                                           context, 'Chat with ${msg.sender}'),
//                                     ),
//                                     const SizedBox(height: 18),
//                                     NotificationsCard(
//                                       notifications: notifs,
//                                       isDarkMode: isDarkMode,
//                                       onNotificationTap: (n) =>
//                                           _handleQuickAction(context,
//                                               'Alert from ${n.sender}'),
//                                     ),
//                                   ],
//                                 )
//                               else
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       child: RecentDocumentsCard(
//                                         documents: recentDocs,
//                                         isDarkMode: isDarkMode,
//                                         onDocumentTap: (doc) =>
//                                             _handleQuickAction(
//                                                 context, 'Opening ${doc.name}'),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 18),
//                                     Expanded(
//                                       child: RecentMessagesCard(
//                                         messages: recentMsgs,
//                                         isDarkMode: isDarkMode,
//                                         onMessageTap: (msg) =>
//                                             _handleQuickAction(context,
//                                                 'Chat with ${msg.sender}'),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 18),
//                                     Expanded(
//                                       child: NotificationsCard(
//                                         notifications: notifs,
//                                         isDarkMode: isDarkMode,
//                                         onNotificationTap: (n) =>
//                                             _handleQuickAction(context,
//                                                 'Alert from ${n.sender}'),
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                               const SizedBox(height: 24),

//                               // 3 Quick Action Cards along the bottom
//                               QuickActionsRow(
//                                 isDarkMode: isDarkMode,
//                                 onActionTap: (action) =>
//                                     _handleQuickAction(context, action),
//                               ),

//                               const SizedBox(height: 32),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildDesktopSummaryRow(SummaryStats stats, bool isDarkMode) {
//     return Row(
//       children: [
//         Expanded(
//           child: DashboardSummaryCard(
//             icon: Icons.chat_bubble_outline_rounded,
//             count: stats.unreadMessagesCount,
//             label: AppStrings.unreadMessages,
//             isDarkMode: isDarkMode,
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: DashboardSummaryCard(
//             icon: Icons.description_outlined,
//             count: stats.documentsCount,
//             label: AppStrings.documents,
//             isDarkMode: isDarkMode,
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: DashboardSummaryCard(
//             icon: Icons.upload_outlined,
//             count: stats.sharedWithMeCount,
//             label: AppStrings.sharedWithMe,
//             isDarkMode: isDarkMode,
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: DashboardSummaryCard(
//             icon: Icons.notifications_none_rounded,
//             count: stats.notificationsCount,
//             label: AppStrings.notifications,
//             isDarkMode: isDarkMode,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMobileSummaryGrid(SummaryStats stats, bool isDarkMode) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: DashboardSummaryCard(
//                 icon: Icons.chat_bubble_outline_rounded,
//                 count: stats.unreadMessagesCount,
//                 label: AppStrings.unreadMessages,
//                 isDarkMode: isDarkMode,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: DashboardSummaryCard(
//                 icon: Icons.description_outlined,
//                 count: stats.documentsCount,
//                 label: AppStrings.documents,
//                 isDarkMode: isDarkMode,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             Expanded(
//               child: DashboardSummaryCard(
//                 icon: Icons.upload_outlined,
//                 count: stats.sharedWithMeCount,
//                 label: AppStrings.sharedWithMe,
//                 isDarkMode: isDarkMode,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: DashboardSummaryCard(
//                 icon: Icons.notifications_none_rounded,
//                 count: stats.notificationsCount,
//                 label: AppStrings.notifications,
//                 isDarkMode: isDarkMode,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../routes/app_routes.dart';
import '../bloc/dashboard/dashboard_bloc.dart';
import '../bloc/dashboard/dashboard_event.dart';
import '../bloc/dashboard/dashboard_state.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/dashboard_content_cards.dart';
import '../widgets/dashboard_summary_card.dart';

class DashboardScreen extends StatefulWidget {
  final ValueChanged<int>? onNavItemSelected;
  const DashboardScreen({super.key, this.onNavItemSelected});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(const LoadDashboardData());
  }

  void _handleQuickAction(BuildContext context, String actionName) {
    if (actionName == AppStrings.newChat ||
        actionName.startsWith('Chat with')) {
      // Navigator.of(context).pushNamed(AppRoutes.messages);
      widget.onNavItemSelected?.call(1);
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: Text(
          actionName,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Action "$actionName" has been triggered. Module connection will be wired in next phase.',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK',
                style: TextStyle(color: AppColors.primaryOrange)),
          ),
        ],
      ),
    );
  }

  void _handleSignOut(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 960;

    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if (state.lastTriggeredAction != null) {
          _handleQuickAction(context, state.lastTriggeredAction!);
        }
      },
      builder: (context, state) {
        final data = state.data;
        final isDarkMode = state.isDarkMode;

        if (state.isLoading && data == null) {
          return const Scaffold(
            backgroundColor: AppColors.dashboardBg,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primaryOrange),
            ),
          );
        }

        // Fallback default dataset if data is loading for instant responsive preview
        final stats = data?.stats ??
            const SummaryStats(
              unreadMessagesCount: 5,
              documentsCount: 3,
              sharedWithMeCount: 2,
              notificationsCount: 6,
            );
        final recentDocs = data?.recentDocuments ?? [];
        final recentMsgs = data?.recentMessages ?? [];
        final notifs = data?.notifications ?? [];
        final userName =
            data?.profile.name.split(' ').first ?? AppStrings.defaultUserName;

        return AppScaffold(
          title: AppStrings.dashboardTitle,
          activeNavIndex: 0,
          onNavItemSelected: widget.onNavItemSelected,
          isDarkMode: isDarkMode,
          onThemeToggle: () {
            context.read<DashboardBloc>().add(const ToggleDashboardTheme());
          },
          onNotificationPressed: () {
            _handleQuickAction(context, 'Notifications Panel (6 Unread)');
          },
          onProfilePressed: () {
            _handleQuickAction(context, 'Profile: Yuvi (Admin)');
          },
          onSignOut: () => _handleSignOut(context),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 28,
              vertical: isMobile ? 18 : 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting Header: "Good morning, Syed 👋"
                Row(
                  children: [
                    Text(
                      '${AppStrings.greetingPrefix} $userName',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : AppColors.textDark,
                        fontSize: isMobile ? 22 : 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('👋', style: TextStyle(fontSize: 24)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.greetingSubtitle,
                  style: TextStyle(
                    color: isDarkMode
                        ? const Color(0xFF94A3B8)
                        : AppColors.textGray,
                    fontSize: isMobile ? 13 : 14.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 24),

                // Four Summary Cards:
                // Mobile: 2-column grid. Desktop: 4 horizontal columns.
                if (isMobile)
                  _buildMobileSummaryGrid(stats, isDarkMode)
                else
                  _buildDesktopSummaryRow(stats, isDarkMode),

                const SizedBox(height: 24),

                // Middle Content Cards:
                // Mobile: Stacked vertically. Desktop: 3 horizontal columns.
                if (isMobile)
                  Column(
                    children: [
                      RecentDocumentsCard(
                        documents: recentDocs,
                        isDarkMode: isDarkMode,
                        onDocumentTap: (doc) =>
                            _handleQuickAction(context, 'Opening ${doc.name}'),
                      ),
                      const SizedBox(height: 18),
                      RecentMessagesCard(
                        messages: recentMsgs,
                        isDarkMode: isDarkMode,
                        onMessageTap: (msg) => _handleQuickAction(
                            context, 'Chat with ${msg.sender}'),
                      ),
                      const SizedBox(height: 18),
                      NotificationsCard(
                        notifications: notifs,
                        isDarkMode: isDarkMode,
                        onNotificationTap: (n) => _handleQuickAction(
                            context, 'Alert from ${n.sender}'),
                      ),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: RecentDocumentsCard(
                          documents: recentDocs,
                          isDarkMode: isDarkMode,
                          onDocumentTap: (doc) => _handleQuickAction(
                              context, 'Opening ${doc.name}'),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: RecentMessagesCard(
                          messages: recentMsgs,
                          isDarkMode: isDarkMode,
                          onMessageTap: (msg) => _handleQuickAction(
                              context, 'Chat with ${msg.sender}'),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: NotificationsCard(
                          notifications: notifs,
                          isDarkMode: isDarkMode,
                          onNotificationTap: (n) => _handleQuickAction(
                              context, 'Alert from ${n.sender}'),
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 24),

                // 3 Quick Action Cards along the bottom
                QuickActionsRow(
                  isDarkMode: isDarkMode,
                  onActionTap: (action) => _handleQuickAction(context, action),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopSummaryRow(SummaryStats stats, bool isDarkMode) {
    return Row(
      children: [
        Expanded(
          child: DashboardSummaryCard(
            icon: Icons.chat_bubble_outline_rounded,
            count: stats.unreadMessagesCount,
            label: AppStrings.unreadMessages,
            isDarkMode: isDarkMode,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DashboardSummaryCard(
            icon: Icons.description_outlined,
            count: stats.documentsCount,
            label: AppStrings.documents,
            isDarkMode: isDarkMode,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DashboardSummaryCard(
            icon: Icons.upload_outlined,
            count: stats.sharedWithMeCount,
            label: AppStrings.sharedWithMe,
            isDarkMode: isDarkMode,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DashboardSummaryCard(
            icon: Icons.notifications_none_rounded,
            count: stats.notificationsCount,
            label: AppStrings.notifications,
            isDarkMode: isDarkMode,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileSummaryGrid(SummaryStats stats, bool isDarkMode) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DashboardSummaryCard(
                icon: Icons.chat_bubble_outline_rounded,
                count: stats.unreadMessagesCount,
                label: AppStrings.unreadMessages,
                isDarkMode: isDarkMode,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DashboardSummaryCard(
                icon: Icons.description_outlined,
                count: stats.documentsCount,
                label: AppStrings.documents,
                isDarkMode: isDarkMode,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DashboardSummaryCard(
                icon: Icons.upload_outlined,
                count: stats.sharedWithMeCount,
                label: AppStrings.sharedWithMe,
                isDarkMode: isDarkMode,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DashboardSummaryCard(
                icon: Icons.notifications_none_rounded,
                count: stats.notificationsCount,
                label: AppStrings.notifications,
                isDarkMode: isDarkMode,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
