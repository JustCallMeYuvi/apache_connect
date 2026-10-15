import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/entities/app_notification.dart';
import '../bloc/notifications/notifications_bloc.dart';
import '../bloc/notifications/notifications_event.dart';
import '../bloc/notifications/notifications_state.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/notification_details_bottom_sheet.dart';
import '../widgets/notification_details_panel.dart';
import '../widgets/notification_list_item.dart';

/// Notifications Screen in ApacheConnect following Clean Architecture & BLoC pattern
class NotificationsScreen extends StatefulWidget {
  final ValueChanged<int>? onNavItemSelected;

  const NotificationsScreen({
    super.key,
    this.onNavItemSelected,
  });

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<NotificationsBloc>();
    if (bloc.state.status == NotificationsStatus.initial) {
      bloc.add(const LoadNotificationsEvent());
    }
  }

  void _handleOpenNotification(BuildContext context, AppNotification notif) {
    if (notif.targetRoute != null) {
      Navigator.of(context).pushReplacementNamed(notif.targetRoute!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Opening ${notif.sender}\'s update...'),
          backgroundColor: AppColors.primaryOrange,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _handleMarkAllRead(BuildContext context) {
    context
        .read<NotificationsBloc>()
        .add(const MarkAllNotificationsReadEvent());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.allNotificationsReadSuccess),
        backgroundColor: AppColors.primaryOrange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleDeleteNotification(BuildContext context, String id) {
    context.read<NotificationsBloc>().add(DeleteNotificationEvent(id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.notificationDeletedSuccess),
        backgroundColor: AppColors.primaryOrange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleToggleRead(BuildContext context, String id) {
    context
        .read<NotificationsBloc>()
        .add(ToggleNotificationReadStatusEvent(id));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 960;

    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        final notifications = state.notifications;
        final selectedNotif = state.selectedNotification;
        final unreadCount = state.unreadCount;

        // Auto-select first item on desktop if none selected
        if (!isMobile &&
            selectedNotif == null &&
            notifications.isNotEmpty &&
            state.selectedNotificationId == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context
                .read<NotificationsBloc>()
                .add(SelectNotificationEvent(notifications.first.id));
          });
        }

        return AppScaffold(
          title: AppStrings.notificationsTitle,
          activeNavIndex: 3, // 3 = Notifications/Alerts
          isDarkMode: _isDarkMode,
          onNavItemSelected: widget.onNavItemSelected,

          notificationCount: unreadCount,
          onThemeToggle: () {
            setState(() => _isDarkMode = !_isDarkMode);
          },
          onNotificationPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You have $unreadCount unread notification(s)'),
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
          body: isMobile
              ? _buildMobileContent(context, state, notifications)
              : _buildDesktopContent(
                  context, state, notifications, selectedNotif),
        );
      },
    );
  }

  /// Desktop Layout: Two-panel layout matching Screenshot 1
  Widget _buildDesktopContent(
    BuildContext context,
    NotificationsState state,
    List<AppNotification> notifications,
    AppNotification? selectedNotif,
  ) {
    return Row(
      children: [
        // Left Panel: Notification List (width: 390px)
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
              // Header: "Notifications" Title + "Mark all read" Button
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 22, bottom: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.notificationsTitle,
                      style: TextStyle(
                        color: _isDarkMode ? Colors.white : AppColors.textDark,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),
                    InkWell(
                      onTap: () => _handleMarkAllRead(context),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: _isDarkMode
                              ? const Color(0xFF334155)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          AppStrings.markAllRead,
                          style: TextStyle(
                            color: _isDarkMode
                                ? Colors.white
                                : const Color(0xFF1E293B),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1, color: Color(0x14000000)),

              // Scrollable Notifications List
              Expanded(
                child: state.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryOrange),
                      )
                    : notifications.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.notifications_off_outlined,
                                  size: 40,
                                  color: _isDarkMode
                                      ? const Color(0xFF64748B)
                                      : const Color(0xFF94A3B8),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  AppStrings.noNotificationsFound,
                                  style: TextStyle(
                                    color: _isDarkMode
                                        ? const Color(0xFF94A3B8)
                                        : AppColors.textGray,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: notifications.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 2),
                            itemBuilder: (context, index) {
                              final notif = notifications[index];
                              final isSelected =
                                  notif.id == state.selectedNotificationId;

                              return NotificationListItem(
                                notification: notif,
                                isSelected: isSelected,
                                isDarkMode: _isDarkMode,
                                onTap: () {
                                  context
                                      .read<NotificationsBloc>()
                                      .add(SelectNotificationEvent(notif.id));
                                },
                              );
                            },
                          ),
              ),
            ],
          ),
        ),

        // Right Panel: Selected Notification Details
        Expanded(
          child: Container(
            color:
                _isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFFAFAFA),
            child: NotificationDetailsPanel(
              notification: selectedNotif,
              isDarkMode: _isDarkMode,
              onOpen: () {
                if (selectedNotif != null) {
                  _handleOpenNotification(context, selectedNotif);
                }
              },
              onToggleRead: () {
                if (selectedNotif != null) {
                  _handleToggleRead(context, selectedNotif.id);
                }
              },
              onDelete: () {
                if (selectedNotif != null) {
                  _handleDeleteNotification(context, selectedNotif.id);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Mobile Layout: Single-column list matching Screenshot 2
  Widget _buildMobileContent(
    BuildContext context,
    NotificationsState state,
    List<AppNotification> notifications,
  ) {
    return Container(
      color: _isDarkMode ? const Color(0xFF1E293B) : Colors.white,
      child: Column(
        children: [
          // Header: "Notifications" Title + "Mark all read" Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.notificationsTitle,
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : AppColors.textDark,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
                InkWell(
                  onTap: () => _handleMarkAllRead(context),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: _isDarkMode
                          ? const Color(0xFF334155)
                          : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      AppStrings.markAllRead,
                      style: TextStyle(
                        color: _isDarkMode
                            ? Colors.white
                            : const Color(0xFF1E293B),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0x14000000)),

          // Single-column scrollable notifications list
          Expanded(
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryOrange),
                  )
                : notifications.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_off_outlined,
                              size: 40,
                              color: _isDarkMode
                                  ? const Color(0xFF64748B)
                                  : const Color(0xFF94A3B8),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              AppStrings.noNotificationsFound,
                              style: TextStyle(
                                color: _isDarkMode
                                    ? const Color(0xFF94A3B8)
                                    : AppColors.textGray,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: notifications.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 2),
                        itemBuilder: (context, index) {
                          final notif = notifications[index];

                          return NotificationListItem(
                            notification: notif,
                            isSelected: false,
                            isDarkMode: _isDarkMode,
                            onTap: () {
                              // Open mobile bottom sheet with details & actions
                              NotificationDetailsBottomSheet.show(
                                context: context,
                                notification: notif,
                                isDarkMode: _isDarkMode,
                                onOpen: () =>
                                    _handleOpenNotification(context, notif),
                                onToggleRead: () =>
                                    _handleToggleRead(context, notif.id),
                                onDelete: () => _handleDeleteNotification(
                                    context, notif.id),
                              );
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
