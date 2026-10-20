// import 'package:apache_connect/presentation/widgets/new_group_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../core/constants/app_colors.dart';
// import '../../core/constants/app_strings.dart';
// import '../../domain/entities/chat_conversation.dart';
// import '../../routes/app_routes.dart';
// import '../bloc/messages/messages_bloc.dart';
// import '../bloc/messages/messages_event.dart';
// import '../bloc/messages/messages_state.dart';
// import '../widgets/chat_conversation_view.dart';
// import '../widgets/chat_empty_view.dart';
// import '../widgets/chat_filter_tabs.dart';
// import '../widgets/chat_list_item.dart';
// import '../widgets/chat_search_bar.dart';
// import '../widgets/dashboard_bottom_nav.dart';
// import '../widgets/dashboard_sidebar.dart';
// import '../widgets/dashboard_top_bar.dart';

// class MessagesScreen extends StatefulWidget {
//   const MessagesScreen({super.key});

//   @override
//   State<MessagesScreen> createState() => _MessagesScreenState();
// }

// class _MessagesScreenState extends State<MessagesScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final TextEditingController _searchController = TextEditingController();
//   bool _isDarkMode = false;

//   @override
//   void initState() {
//     super.initState();
//     context.read<MessagesBloc>().add(const LoadMessagesEvent());
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _showNewGroupDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (ctx) => NewGroupDialog(
//         isDarkMode: _isDarkMode,
//         onCreateGroup: (name) {
//           context.read<MessagesBloc>().add(CreateGroupEvent(name: name));
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Group "$name" created successfully'),
//               backgroundColor: AppColors.primaryOrange,
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isMobile = size.width < 960;

//     return BlocBuilder<MessagesBloc, MessagesState>(
//       builder: (context, state) {
//         final conversations = state.filteredConversations;
//         final selectedConv = state.selectedConversation;

//         return Scaffold(
//           key: _scaffoldKey,
//           backgroundColor:
//               _isDarkMode ? AppColors.dashboardDarkBg : AppColors.dashboardBg,
//           drawer: isMobile
//               ? Drawer(
//                   child: DashboardSidebar(
//                     selectedIndex: 1, // 1 = Messages
//                     onItemSelected: (idx) {
//                       Navigator.of(context).pop();
//                       if (idx == 0) {
//                         Navigator.of(context)
//                             .pushReplacementNamed(AppRoutes.dashboard);
//                       }
//                     },
//                     onSignOut: () {
//                       Navigator.of(context)
//                           .pushReplacementNamed(AppRoutes.login);
//                     },
//                   ),
//                 )
//               : null,
//           // bottomNavigationBar: isMobile && selectedConv == null
//           //     ? DashboardBottomNav(
//           //         selectedIndex: 1, // 1 = Chats active
//           //         onIndexChanged: (idx) {
//           //           if (idx == 0) {
//           //             Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
//           //           }
//           //         },
//           //         isDarkMode: _isDarkMode,
//           //       )
//           //     : null,

//           bottomNavigationBar: isMobile && selectedConv == null
//               ? DashboardBottomNav(
//                   selectedIndex: 1,
//                   onIndexChanged: (idx) {
//                     switch (idx) {
//                       case 0:
//                         Navigator.of(context).pushReplacementNamed(
//                           AppRoutes.dashboard,
//                         );
//                         break;

//                       case 1:
//                         // Already on Messages.
//                         break;

//                       case 2:
//                         break;

//                       case 3:
//                         break;

//                       case 4:
//                         break;
//                     }
//                   },
//                   isDarkMode: _isDarkMode,
//                 )
//               : null,
//           floatingActionButton: isMobile && selectedConv == null
//               ? FloatingActionButton(
//                   onPressed: () => _showNewGroupDialog(context),
//                   backgroundColor: AppColors.primaryOrange,
//                   foregroundColor: Colors.white,
//                   elevation: 6,
//                   shape: const CircleBorder(),
//                   child: const Icon(Icons.add, size: 28),
//                 )
//               : null,
//           body: Row(
//             children: [
//               // Desktop Fixed Left Sidebar
//               if (!isMobile)
//                 DashboardSidebar(
//                   selectedIndex: 1, // 1 = Messages
//                   onItemSelected: (idx) {
//                     if (idx == 0) {
//                       Navigator.of(context)
//                           .pushReplacementNamed(AppRoutes.dashboard);
//                     }
//                   },
//                   onSignOut: () {
//                     Navigator.of(context).pushReplacementNamed(AppRoutes.login);
//                   },
//                 ),

//               // Main Canvas
//               Expanded(
//                 child: Column(
//                   children: [
//                     // Top App Bar
//                     DashboardTopBar(
//                       isMobile: isMobile,
//                       isDarkMode: _isDarkMode,
//                       onMenuPressed: () {
//                         if (isMobile) {
//                           _scaffoldKey.currentState?.openDrawer();
//                         }
//                       },
//                       onThemeToggle: () {
//                         setState(() => _isDarkMode = !_isDarkMode);
//                       },
//                       onNotificationPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Notifications (211 unread)'),
//                             behavior: SnackBarBehavior.floating,
//                           ),
//                         );
//                       },
//                       onProfilePressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Logged in as Syed Imran (Admin)'),
//                             behavior: SnackBarBehavior.floating,
//                           ),
//                         );
//                       },
//                     ),

//                     // Content Area: Responsive Master-Detail Layout
//                     Expanded(
//                       child: isMobile
//                           ? _buildMobileContent(state, selectedConv)
//                           : _buildDesktopContent(state, selectedConv),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Desktop Master-Detail Layout (matches Desktop Screenshot)
//   Widget _buildDesktopContent(
//       MessagesState state, ChatConversation? selectedConv) {
//     return Row(
//       children: [
//         // Left Column: Chat List Panel
//         Container(
//           width: 390,
//           decoration: BoxDecoration(
//             color: _isDarkMode ? const Color(0xFF1E293B) : Colors.white,
//             border: Border(
//               right: BorderSide(
//                 color: _isDarkMode
//                     ? const Color(0x1AFFFFFF)
//                     : const Color(0xFFE2E8F0),
//                 width: 1,
//               ),
//             ),
//           ),
//           child: Column(
//             children: [
//               // Chat Header & Search Area
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 20, right: 20, top: 20, bottom: 12),
//                 child: Column(
//                   children: [
//                     // Title and "New group" Button
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           AppStrings.messagesTitle,
//                           style: TextStyle(
//                             color:
//                                 _isDarkMode ? Colors.white : AppColors.textDark,
//                             fontSize: 22,
//                             fontWeight: FontWeight.w800,
//                             letterSpacing: -0.4,
//                           ),
//                         ),
//                         ElevatedButton.icon(
//                           onPressed: () => _showNewGroupDialog(context),
//                           icon: const Icon(Icons.group_add_outlined, size: 16),
//                           label: const Text(
//                             AppStrings.newGroup,
//                             style: TextStyle(
//                                 fontSize: 12.5, fontWeight: FontWeight.w700),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primaryOrange,
//                             foregroundColor: Colors.white,
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 14, vertical: 8),
//                             minimumSize: const Size(0, 36),
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 16),

//                     // Search Employees or Chats Input Bar
//                     ChatSearchBar(
//                       controller: _searchController,
//                       isDarkMode: _isDarkMode,
//                       onChanged: (val) {
//                         context
//                             .read<MessagesBloc>()
//                             .add(SearchQueryChangedEvent(val));
//                       },
//                       onClear: () {
//                         context
//                             .read<MessagesBloc>()
//                             .add(const SearchQueryChangedEvent(''));
//                       },
//                     ),

//                     const SizedBox(height: 14),

//                     // All / Direct / Groups Filter Tabs
//                     ChatFilterTabs(
//                       selectedFilter: state.selectedFilter,
//                       isDarkMode: _isDarkMode,
//                       onFilterChanged: (filter) {
//                         context
//                             .read<MessagesBloc>()
//                             .add(FilterTabChangedEvent(filter));
//                       },
//                     ),
//                   ],
//                 ),
//               ),

//               const Divider(height: 1, color: Color(0x14000000)),

//               // Chat List Scroll View
//               Expanded(
//                 child: state.isLoading
//                     ? const Center(
//                         child: CircularProgressIndicator(
//                             color: AppColors.primaryOrange),
//                       )
//                     : state.filteredConversations.isEmpty
//                         ? Center(
//                             child: Text(
//                               'No conversations found',
//                               style: TextStyle(
//                                 color: _isDarkMode
//                                     ? const Color(0xFF94A3B8)
//                                     : AppColors.textGray,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           )
//                         : ListView.separated(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 10),
//                             itemCount: state.filteredConversations.length,
//                             separatorBuilder: (_, __) =>
//                                 const SizedBox(height: 2),
//                             itemBuilder: (context, index) {
//                               final conv = state.filteredConversations[index];
//                               final isSelected =
//                                   conv.id == state.selectedConversationId;

//                               return ChatListItem(
//                                 conversation: conv,
//                                 isSelected: isSelected,
//                                 isDarkMode: _isDarkMode,
//                                 onTap: () {
//                                   context
//                                       .read<MessagesBloc>()
//                                       .add(SelectConversationEvent(conv.id));
//                                 },
//                               );
//                             },
//                           ),
//               ),
//             ],
//           ),
//         ),

//         // Right Column: Active Conversation or Empty View
//         Expanded(
//           child: selectedConv != null
//               ? ChatConversationView(
//                   conversation: selectedConv,
//                   isDarkMode: _isDarkMode,
//                   isMobile: false,
//                   onClose: () {
//                     context
//                         .read<MessagesBloc>()
//                         .add(const ClearSelectedConversationEvent());
//                   },
//                   onSendMessage: (msg) {
//                     context.read<MessagesBloc>().add(SendMessageEvent(msg));
//                   },
//                 )
//               : ChatEmptyView(isDarkMode: _isDarkMode),
//         ),
//       ],
//     );
//   }

//   // Mobile Single-Pane Layout (matches Mobile Screenshot)
//   Widget _buildMobileContent(
//       MessagesState state, ChatConversation? selectedConv) {
//     if (selectedConv != null) {
//       // In active chat on mobile
//       return ChatConversationView(
//         conversation: selectedConv,
//         isDarkMode: _isDarkMode,
//         isMobile: true,
//         onClose: () {
//           context
//               .read<MessagesBloc>()
//               .add(const ClearSelectedConversationEvent());
//         },
//         onSendMessage: (msg) {
//           context.read<MessagesBloc>().add(SendMessageEvent(msg));
//         },
//       );
//     }

//     // Default chat list screen on mobile
//     return Container(
//       color: _isDarkMode ? const Color(0xFF1E293B) : Colors.white,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
//             child: Column(
//               children: [
//                 // Header Row: "Messages" + "New group" Button
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       AppStrings.messagesTitle,
//                       style: TextStyle(
//                         color: _isDarkMode ? Colors.white : AppColors.textDark,
//                         fontSize: 22,
//                         fontWeight: FontWeight.w800,
//                         letterSpacing: -0.4,
//                       ),
//                     ),
//                     ElevatedButton.icon(
//                       onPressed: () => _showNewGroupDialog(context),
//                       icon: const Icon(Icons.group_add_outlined, size: 16),
//                       label: const Text(
//                         AppStrings.newGroup,
//                         style: TextStyle(
//                             fontSize: 12.5, fontWeight: FontWeight.w700),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryOrange,
//                         foregroundColor: Colors.white,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 14, vertical: 8),
//                         minimumSize: const Size(0, 36),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 14),

//                 // Search Bar
//                 ChatSearchBar(
//                   controller: _searchController,
//                   isDarkMode: _isDarkMode,
//                   onChanged: (val) {
//                     context
//                         .read<MessagesBloc>()
//                         .add(SearchQueryChangedEvent(val));
//                   },
//                   onClear: () {
//                     context
//                         .read<MessagesBloc>()
//                         .add(const SearchQueryChangedEvent(''));
//                   },
//                 ),

//                 const SizedBox(height: 12),

//                 // Filter Tabs: All / Direct / Groups
//                 ChatFilterTabs(
//                   selectedFilter: state.selectedFilter,
//                   isDarkMode: _isDarkMode,
//                   onFilterChanged: (filter) {
//                     context
//                         .read<MessagesBloc>()
//                         .add(FilterTabChangedEvent(filter));
//                   },
//                 ),
//               ],
//             ),
//           ),

//           const Divider(height: 1, color: Color(0x14000000)),

//           // Scrollable Chat List Items
//           Expanded(
//             child: ListView.separated(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//               itemCount: state.filteredConversations.length,
//               separatorBuilder: (_, __) => const SizedBox(height: 2),
//               itemBuilder: (context, index) {
//                 final conv = state.filteredConversations[index];

//                 return ChatListItem(
//                   conversation: conv,
//                   isSelected: false,
//                   isDarkMode: _isDarkMode,
//                   onTap: () {
//                     context
//                         .read<MessagesBloc>()
//                         .add(SelectConversationEvent(conv.id));
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:apache_connect/presentation/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/entities/chat_conversation.dart';
import '../bloc/messages/messages_bloc.dart';
import '../bloc/messages/messages_event.dart';
import '../bloc/messages/messages_state.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/chat_conversation_view.dart';
import '../widgets/chat_empty_view.dart';
import '../widgets/chat_filter_tabs.dart';
import '../widgets/chat_list_item.dart';
import '../widgets/chat_search_bar.dart';
import '../widgets/new_group_dialog.dart';

class MessagesScreen extends StatefulWidget {
  final ValueChanged<int>? onNavItemSelected;

  const MessagesScreen({super.key, this.onNavItemSelected});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    context.read<MessagesBloc>().add(const LoadMessagesEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showNewGroupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => NewGroupDialog(
        isDarkMode: _isDarkMode,
        onCreateGroup: (name) {
          context.read<MessagesBloc>().add(CreateGroupEvent(name: name));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Group "$name" created successfully'),
              backgroundColor: AppColors.primaryOrange,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 960;

    return BlocBuilder<MessagesBloc, MessagesState>(
      builder: (context, state) {
        // final conversations = state.filteredConversations;
        final selectedConv = state.selectedConversation;
        final loginState = context.read<LoginBloc>().state;
        final user = loginState.authenticatedUser;
        return AppScaffold(
          title: AppStrings.messagesTitle,
          activeNavIndex: 1,
          //           employeeName: authenticatedUser.name,
          // employeeNo: authenticatedUser.id,
          employeeName:
              user?.displayName ?? user?.username ?? 'Unknown Employee',
          employeeNo: user?.id ?? 'Unknown ID',

          onNavItemSelected: widget.onNavItemSelected,
          isDarkMode: _isDarkMode,
          onThemeToggle: () {
            setState(() => _isDarkMode = !_isDarkMode);
          },
          onNotificationPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Notifications (6 unread)'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          onProfilePressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Logged in as Syed Imran (Admin)'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          floatingActionButton: isMobile && selectedConv == null
              ? FloatingActionButton(
                  //  heroTag: 'messagesFab',
                  heroTag: null,
                  onPressed: () => _showNewGroupDialog(context),
                  backgroundColor: AppColors.primaryOrange,
                  foregroundColor: Colors.white,
                  elevation: 6,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add, size: 28),
                )
              : null,
          body: isMobile
              ? _buildMobileContent(state, selectedConv)
              : _buildDesktopContent(state, selectedConv),
        );
      },
    );
  }

  // Desktop Master-Detail Layout (matches Desktop Screenshot)
  Widget _buildDesktopContent(
      MessagesState state, ChatConversation? selectedConv) {
    return Row(
      children: [
        // Left Column: Chat List Panel
        Container(
          width: 390,
          decoration: BoxDecoration(
            color: _isDarkMode ? const Color(0xFF1E293B) : Colors.white,
            border: Border(
              right: BorderSide(
                color: _isDarkMode
                    ? const Color(0x1AFFFFFF)
                    : const Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              // Chat Header & Search Area
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 12),
                child: Column(
                  children: [
                    // Title and "New group" Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.messagesTitle,
                          style: TextStyle(
                            color:
                                _isDarkMode ? Colors.white : AppColors.textDark,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _showNewGroupDialog(context),
                          icon: const Icon(Icons.group_add_outlined, size: 16),
                          label: const Text(
                            AppStrings.newGroup,
                            style: TextStyle(
                                fontSize: 12.5, fontWeight: FontWeight.w700),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryOrange,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            minimumSize: const Size(0, 36),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Search Employees or Chats Input Bar
                    ChatSearchBar(
                      controller: _searchController,
                      isDarkMode: _isDarkMode,
                      onChanged: (val) {
                        context
                            .read<MessagesBloc>()
                            .add(SearchQueryChangedEvent(val));
                      },
                      onClear: () {
                        context
                            .read<MessagesBloc>()
                            .add(const SearchQueryChangedEvent(''));
                      },
                    ),

                    const SizedBox(height: 14),

                    // All / Direct / Groups Filter Tabs
                    ChatFilterTabs(
                      selectedFilter: state.selectedFilter,
                      isDarkMode: _isDarkMode,
                      onFilterChanged: (filter) {
                        context
                            .read<MessagesBloc>()
                            .add(FilterTabChangedEvent(filter));
                      },
                    ),
                  ],
                ),
              ),

              const Divider(height: 1, color: Color(0x14000000)),

              // Chat List Scroll View
              Expanded(
                child: state.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryOrange),
                      )
                    : state.filteredConversations.isEmpty
                        ? Center(
                            child: Text(
                              'No conversations found',
                              style: TextStyle(
                                color: _isDarkMode
                                    ? const Color(0xFF94A3B8)
                                    : AppColors.textGray,
                                fontSize: 13,
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            itemCount: state.filteredConversations.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 2),
                            itemBuilder: (context, index) {
                              final conv = state.filteredConversations[index];
                              final isSelected =
                                  conv.id == state.selectedConversationId;

                              return ChatListItem(
                                conversation: conv,
                                isSelected: isSelected,
                                isDarkMode: _isDarkMode,
                                onTap: () {
                                  context
                                      .read<MessagesBloc>()
                                      .add(SelectConversationEvent(conv.id));
                                },
                              );
                            },
                          ),
              ),
            ],
          ),
        ),

        // Right Column: Active Conversation or Empty View
        Expanded(
          child: selectedConv != null
              ? ChatConversationView(
                  conversation: selectedConv,
                  isDarkMode: _isDarkMode,
                  isMobile: false,
                  onClose: () {
                    context
                        .read<MessagesBloc>()
                        .add(const ClearSelectedConversationEvent());
                  },
                  // onSendMessage: (msg) {
                  //   context.read<MessagesBloc>().add(SendMessageEvent(msg));
                  // },

                  onSendMessage: (msg) {
                    context.read<MessagesBloc>().add(
                          SendMessageEvent(
                            msg,
                            conversationId: selectedConv.id,
                          ),
                        );
                  },

                  onSendWithAttachment: (
                    msg, {
                    attachmentName,
                    attachmentType,
                    attachmentSize,
                    attachmentUrl,
                    attachmentBytes,
                  }) {
                    context.read<MessagesBloc>().add(
                          SendMessageEvent(
                            msg,
                            conversationId: selectedConv.id,
                            attachmentName: attachmentName,
                            attachmentType: attachmentType,
                            attachmentSize: attachmentSize,
                            attachmentUrl: attachmentUrl,
                            attachmentBytes: attachmentBytes,
                          ),
                        );
                  },
                )
              : ChatEmptyView(isDarkMode: _isDarkMode),
        ),
      ],
    );
  }

  // Mobile Single-Pane Layout (matches Mobile Screenshot)
  Widget _buildMobileContent(
      MessagesState state, ChatConversation? selectedConv) {
    if (selectedConv != null) {
      // In active chat on mobile
      return ChatConversationView(
        conversation: selectedConv,
        isDarkMode: _isDarkMode,
        isMobile: true,
        onClose: () {
          context
              .read<MessagesBloc>()
              .add(const ClearSelectedConversationEvent());
        },
        // onSendMessage: (msg) {
        //   context.read<MessagesBloc>().add(SendMessageEvent(msg));
        // },

        onSendMessage: (msg) {
          context.read<MessagesBloc>().add(
                SendMessageEvent(
                  msg,
                  conversationId: selectedConv.id,
                ),
              );
        },

        onSendWithAttachment: (
          msg, {
          attachmentName,
          attachmentType,
          attachmentSize,
          attachmentUrl,
          attachmentBytes,
        }) {
          context.read<MessagesBloc>().add(
                SendMessageEvent(
                  msg,
                  conversationId: selectedConv.id,
                  attachmentName: attachmentName,
                  attachmentType: attachmentType,
                  attachmentSize: attachmentSize,
                  attachmentUrl: attachmentUrl,
                  attachmentBytes: attachmentBytes,
                ),
              );
        },
      );
    }

    // Default chat list screen on mobile
    return Container(
      color: _isDarkMode ? const Color(0xFF1E293B) : Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Column(
              children: [
                // Header Row: "Messages" + "New group" Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.messagesTitle,
                      style: TextStyle(
                        color: _isDarkMode ? Colors.white : AppColors.textDark,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _showNewGroupDialog(context),
                      icon: const Icon(Icons.group_add_outlined, size: 16),
                      label: const Text(
                        AppStrings.newGroup,
                        style: TextStyle(
                            fontSize: 12.5, fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        minimumSize: const Size(0, 36),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Search Bar
                ChatSearchBar(
                  controller: _searchController,
                  isDarkMode: _isDarkMode,
                  onChanged: (val) {
                    context
                        .read<MessagesBloc>()
                        .add(SearchQueryChangedEvent(val));
                  },
                  onClear: () {
                    context
                        .read<MessagesBloc>()
                        .add(const SearchQueryChangedEvent(''));
                  },
                ),

                const SizedBox(height: 12),

                // Filter Tabs: All / Direct / Groups
                ChatFilterTabs(
                  selectedFilter: state.selectedFilter,
                  isDarkMode: _isDarkMode,
                  onFilterChanged: (filter) {
                    context
                        .read<MessagesBloc>()
                        .add(FilterTabChangedEvent(filter));
                  },
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0x14000000)),

          // Scrollable Chat List Items
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              itemCount: state.filteredConversations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 2),
              itemBuilder: (context, index) {
                final conv = state.filteredConversations[index];

                return ChatListItem(
                  conversation: conv,
                  isSelected: false,
                  isDarkMode: _isDarkMode,
                  onTap: () {
                    context
                        .read<MessagesBloc>()
                        .add(SelectConversationEvent(conv.id));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
