import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';

class ChatEmptyView extends StatelessWidget {
  final bool isDarkMode;

  const ChatEmptyView({
    super.key,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.chat_bubble_outline_rounded,
            size: 54,
            color: isDarkMode ? const Color(0xFF475569) : const Color(0xFFCBD5E1),
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.selectConversation,
            style: TextStyle(
              color: isDarkMode ? Colors.white : const Color(0xFF334155),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            AppStrings.selectConversationSubtitle,
            style: TextStyle(
              color: isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
