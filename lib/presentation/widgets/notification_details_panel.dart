import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/entities/app_notification.dart';

/// Reusable Right-hand details panel on Desktop/Web matching Screenshot 1
class NotificationDetailsPanel extends StatelessWidget {
  final AppNotification? notification;
  final bool isDarkMode;
  final VoidCallback onOpen;
  final VoidCallback onToggleRead;
  final VoidCallback onDelete;

  const NotificationDetailsPanel({
    super.key,
    required this.notification,
    required this.isDarkMode,
    required this.onOpen,
    required this.onToggleRead,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (notification == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(0xFF1E293B)
                    : const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: 36,
                color: isDarkMode ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.selectNotification,
              style: TextStyle(
                color: isDarkMode ? Colors.white : AppColors.textDark,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              AppStrings.selectNotificationSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDarkMode ? const Color(0xFF94A3B8) : AppColors.textGray,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
    }

    final notif = notification!;
    final categoryTitle = notif.type == NotificationType.mention
        ? AppStrings.userMention
        : AppStrings.directMessage;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Header: Category / Type title + Delete icon button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryTitle,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color(0xFF111827),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline_rounded, size: 20),
                color: isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF4B5563),
                tooltip: AppStrings.deleteNotification,
                splashRadius: 18,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Message Card with Rounded Border matching Screenshot 1
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notif.detailMessage,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : const Color(0xFF1F2937),
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  notif.formattedDate,
                  style: TextStyle(
                    color: isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Action Buttons: Open & Mark unread / read
          Row(
            children: [
              ElevatedButton(
                onPressed: onOpen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                ),
                child: const Text(
                  AppStrings.open,
                  style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(width: 12),

              ElevatedButton(
                onPressed: onToggleRead,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode
                      ? const Color(0xFF334155)
                      : const Color(0xFFF1F5F9),
                  foregroundColor: isDarkMode
                      ? Colors.white
                      : const Color(0xFF1E293B),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                ),
                child: Text(
                  notif.isRead ? AppStrings.markUnread : AppStrings.markRead,
                  style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
