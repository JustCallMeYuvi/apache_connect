import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/entities/app_notification.dart';

/// Mobile bottom sheet for viewing and interacting with a Notification
class NotificationDetailsBottomSheet extends StatelessWidget {
  final AppNotification notification;
  final bool isDarkMode;
  final VoidCallback onOpen;
  final VoidCallback onToggleRead;
  final VoidCallback onDelete;

  const NotificationDetailsBottomSheet({
    super.key,
    required this.notification,
    required this.isDarkMode,
    required this.onOpen,
    required this.onToggleRead,
    required this.onDelete,
  });

  static Future<void> show({
    required BuildContext context,
    required AppNotification notification,
    required bool isDarkMode,
    required VoidCallback onOpen,
    required VoidCallback onToggleRead,
    required VoidCallback onDelete,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => NotificationDetailsBottomSheet(
        notification: notification,
        isDarkMode: isDarkMode,
        onOpen: () {
          Navigator.of(ctx).pop();
          onOpen();
        },
        onToggleRead: () {
          Navigator.of(ctx).pop();
          onToggleRead();
        },
        onDelete: () {
          Navigator.of(ctx).pop();
          onDelete();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryTitle = notification.type == NotificationType.mention
        ? AppStrings.userMention
        : AppStrings.directMessage;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xFF475569)
                      : const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header Row: Category title + Delete button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? const Color(0xFF2E1C16)
                            : const Color(0xFFFEF3EE),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        notification.type == NotificationType.mention
                            ? Icons.notifications_none_rounded
                            : Icons.chat_bubble_outline_rounded,
                        color: AppColors.primaryOrange,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      categoryTitle,
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : const Color(0xFF111827),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline_rounded, size: 22),
                  color: isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF4B5563),
                  tooltip: AppStrings.deleteNotification,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Message Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.detailMessage,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : const Color(0xFF1F2937),
                      fontSize: 14.5,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    notification.formattedDate,
                    style: TextStyle(
                      color: isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onOpen,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      AppStrings.open,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      notification.isRead ? AppStrings.markUnread : AppStrings.markRead,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
