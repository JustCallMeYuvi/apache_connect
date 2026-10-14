import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/app_notification.dart';

/// Reusable Notification list item matching reference screenshots
class NotificationListItem extends StatelessWidget {
  final AppNotification notification;
  final bool isSelected;
  final bool isDarkMode;
  final VoidCallback onTap;

  const NotificationListItem({
    super.key,
    required this.notification,
    required this.isSelected,
    required this.isDarkMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;

    // Selected highlight colors matching reference design
    final selectedBgColor = isDarkMode
        ? const Color(0xFF334155)
        : const Color(0xFFE5E7EB);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? selectedBgColor : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Light peach rounded container with icon
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color(0xFF2E1C16)
                        : const Color(0xFFFEF3EE),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    notification.type == NotificationType.mention
                        ? Icons.notifications_none_rounded
                        : Icons.chat_bubble_outline_rounded,
                    color: AppColors.primaryOrange,
                    size: notification.type == NotificationType.mention ? 22 : 20,
                  ),
                ),

                const SizedBox(width: 14),

                // Sender, message & timestamp
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isUnread)
                        RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '• ',
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: notification.message,
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white : const Color(0xFF1F2937),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.5,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Text(
                          notification.message,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isDarkMode
                                ? const Color(0xFFCBD5E1)
                                : const Color(0xFF4B5563),
                            fontWeight: FontWeight.w500,
                            fontSize: 13.5,
                          ),
                        ),

                      const SizedBox(height: 4),

                      Text(
                        notification.timestamp,
                        style: TextStyle(
                          color: isDarkMode
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF9CA3AF),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
