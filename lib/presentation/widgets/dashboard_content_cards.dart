import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/entities/dashboard_data.dart';

/// Card 1: Recent Documents
class RecentDocumentsCard extends StatelessWidget {
  final List<DocumentItem> documents;
  final bool isDarkMode;
  final ValueChanged<DocumentItem>? onDocumentTap;

  const RecentDocumentsCard({
    super.key,
    required this.documents,
    this.isDarkMode = false,
    this.onDocumentTap,
  });

  @override
  Widget build(BuildContext context) {
    return _buildContainer(
      title: AppStrings.recentDocuments,
      children: documents.map((doc) => _buildDocItem(doc)).toList(),
    );
  }

  Widget _buildContainer({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? const Color(0x1AFFFFFF) : AppColors.cardBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            // color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.02),
            color: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.02),

            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isDarkMode ? Colors.white : AppColors.textDark,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDocItem(DocumentItem doc) {
    Color badgeColor;
    switch (doc.extension.toLowerCase()) {
      case 'pptx':
        badgeColor = AppColors.filePptx;
        break;
      case 'xlsx':
        badgeColor = AppColors.fileXlsx;
        break;
      case 'docx':
        badgeColor = AppColors.fileDocx;
        break;
      default:
        badgeColor = AppColors.primaryOrange;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => onDocumentTap?.call(doc),
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            // Extension icon pill/box
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                doc.extension.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Document info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc.name,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : AppColors.textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${doc.version} · ${doc.date}',
                    style: TextStyle(
                      color: isDarkMode ? const Color(0xFF94A3B8) : AppColors.textGray,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card 2: Recent Messages
class RecentMessagesCard extends StatelessWidget {
  final List<MessageItem> messages;
  final bool isDarkMode;
  final ValueChanged<MessageItem>? onMessageTap;

  const RecentMessagesCard({
    super.key,
    required this.messages,
    this.isDarkMode = false,
    this.onMessageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? const Color(0x1AFFFFFF) : AppColors.cardBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            // color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.02),
            color: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.02),

            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.recentMessages,
            style: TextStyle(
              color: isDarkMode ? Colors.white : AppColors.textDark,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 16),
          ...messages.map((msg) => _buildMessageItem(msg)),
        ],
      ),
    );
  }

  Widget _buildMessageItem(MessageItem msg) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: InkWell(
        onTap: () => onMessageTap?.call(msg),
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            // Avatar
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Color(msg.colorHex),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: msg.isGroup
                      ? const Icon(
                          Icons.groups_rounded,
                          color: Colors.white,
                          size: 20,
                        )
                      : Text(
                          msg.initials ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
                if (msg.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.onlineGreen,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 12),

            // Name & Preview
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    msg.sender,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : AppColors.textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    msg.preview,
                    style: TextStyle(
                      color: isDarkMode ? const Color(0xFF94A3B8) : AppColors.textGray,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Unread badge
            if (msg.unreadBadge > 0)
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: AppColors.badgeOrange,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  msg.unreadBadge.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Card 3: Notifications
class NotificationsCard extends StatelessWidget {
  final List<NotificationItem> notifications;
  final bool isDarkMode;
  final ValueChanged<NotificationItem>? onNotificationTap;

  const NotificationsCard({
    super.key,
    required this.notifications,
    this.isDarkMode = false,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? const Color(0x1AFFFFFF) : AppColors.cardBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            // color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.02),
            color: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.02),

            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.notifications,
            style: TextStyle(
              color: isDarkMode ? Colors.white : AppColors.textDark,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 16),
          ...notifications.map((item) => _buildNotificationItem(item)),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: InkWell(
        onTap: () => onNotificationTap?.call(item),
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF332019) : AppColors.peachIconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.peachIconColor,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : AppColors.textDark,
                    fontSize: 13,
                  ),
                  children: [
                    TextSpan(
                      text: '${item.sender}: ',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: item.description,
                      style: TextStyle(
                        color: isDarkMode ? const Color(0xFF94A3B8) : AppColors.textGray,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 3 Quick Action Cards along the bottom
class QuickActionsRow extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<String>? onActionTap;

  const QuickActionsRow({
    super.key,
    this.isDarkMode = false,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            icon: Icons.add_rounded,
            label: AppStrings.newChat,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionCard(
            icon: Icons.upload_rounded,
            label: AppStrings.uploadDoc,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionCard(
            icon: Icons.person_outline_rounded,
            label: AppStrings.myProfile,
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
  }) {
    return InkWell(
      onTap: () => onActionTap?.call(label),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDarkMode ? const Color(0x1AFFFFFF) : AppColors.cardBorder,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              // color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.02),
              color: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.02),

              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF332019) : AppColors.peachIconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: AppColors.peachIconColor,
                size: 22,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                color: isDarkMode ? Colors.white : AppColors.textDark,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
