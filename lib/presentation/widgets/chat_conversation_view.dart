import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/chat_conversation.dart';

class ChatConversationView extends StatefulWidget {
  final ChatConversation conversation;
  final ValueChanged<String> onSendMessage;
  final VoidCallback onClose;
  final bool isDarkMode;
  final bool isMobile;

  const ChatConversationView({
    super.key,
    required this.conversation,
    required this.onSendMessage,
    required this.onClose,
    this.isDarkMode = false,
    this.isMobile = false,
  });

  @override
  State<ChatConversationView> createState() => _ChatConversationViewState();
}

class _ChatConversationViewState extends State<ChatConversationView> {
  final TextEditingController _messageController = TextEditingController();

  void _send() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      widget.onSendMessage(text);
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final conv = widget.conversation;

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              if (widget.isMobile)
                IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: widget.onClose,
                  color: isDark ? Colors.white : AppColors.textDark,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              if (widget.isMobile) const SizedBox(width: 12),

              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Color(conv.colorHex),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: conv.isGroup
                    ? const Icon(Icons.groups_rounded, color: Colors.white, size: 20)
                    : Text(
                        conv.initials ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      conv.name,
                      style: TextStyle(
                        color: isDark ? Colors.white : AppColors.textDark,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      conv.isGroup
                          ? 'Group workspace · Active'
                          : (conv.isOnline ? 'Online now' : 'Offline'),
                      style: TextStyle(
                        color: conv.isOnline ? AppColors.onlineGreen : const Color(0xFF94A3B8),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (!widget.isMobile)
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 20),
                  color: const Color(0xFF94A3B8),
                  onPressed: widget.onClose,
                ),
            ],
          ),
        ),

        // Message List
        Expanded(
          child: Container(
            color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF7F5F0),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: conv.messages.length,
              itemBuilder: (context, index) {
                final msg = conv.messages[index];
                return Align(
                  alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: const BoxConstraints(maxWidth: 380),
                    decoration: BoxDecoration(
                      color: msg.isMe
                          ? AppColors.primaryOrange
                          : (isDark ? const Color(0xFF1E293B) : Colors.white),
                      borderRadius: BorderRadius.circular(14),
                      border: msg.isMe
                          ? null
                          : Border.all(
                              color: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
                              width: 1,
                            ),
                      boxShadow: [
                        BoxShadow(
                          // color: Colors.black.withOpacity(0.03),
                          color: Colors.black.withValues(alpha: 0.03),

                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                          msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        if (!msg.isMe && conv.isGroup)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              msg.senderName,
                              style: TextStyle(
                                color: isDark ? Colors.amber : AppColors.primaryOrange,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        Text(
                          msg.text,
                          style: TextStyle(
                            color: msg.isMe
                                ? Colors.white
                                : (isDark ? Colors.white : AppColors.textDark),
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          msg.timestamp,
                          style: TextStyle(
                            color: msg.isMe
                                // ? Colors.white.withOpacity(0.7)
                                ? Colors.white.withValues(alpha: 0.7)

                                : const Color(0xFF94A3B8),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Bottom Input Box
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            border: Border(
              top: BorderSide(
                color: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  onSubmitted: (_) => _send(),
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.textDark,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type a message to ${conv.name}...',
                    hintStyle: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 13.5,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: AppColors.primaryOrange),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _send,
                icon: const Icon(Icons.send_rounded),
                color: AppColors.primaryOrange,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
