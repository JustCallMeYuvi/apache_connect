import '../../domain/entities/chat_conversation.dart';

class ChatMessageModel extends ChatMessage {
  const ChatMessageModel({
    required super.id,
    required super.senderName,
    required super.text,
    required super.timestamp,
    required super.isMe,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String? ?? '',
      senderName: json['sender_name'] as String? ?? '',
      text: json['text'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
      isMe: json['is_me'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_name': senderName,
      'text': text,
      'timestamp': timestamp,
      'is_me': isMe,
    };
  }
}

class ChatConversationModel extends ChatConversation {
  const ChatConversationModel({
    required super.id,
    required super.name,
    required super.lastMessage,
    required super.time,
    required super.unreadCount,
    required super.isGroup,
    super.isOnline,
    super.initials,
    required super.colorHex,
    super.messages,
  });

  factory ChatConversationModel.fromJson(Map<String, dynamic> json) {
    final rawMessages = (json['messages'] as List<dynamic>? ?? []);
    final messagesList = rawMessages
        .map((m) => ChatMessageModel.fromJson(m as Map<String, dynamic>))
        .toList();

    return ChatConversationModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      lastMessage: json['last_message'] as String? ?? '',
      time: json['time'] as String? ?? '',
      unreadCount: json['unread_count'] as int? ?? 0,
      isGroup: json['is_group'] as bool? ?? false,
      isOnline: json['is_online'] as bool? ?? false,
      initials: json['initials'] as String?,
      colorHex: json['color_hex'] as int? ?? 0xFF9A3412,
      messages: messagesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_message': lastMessage,
      'time': time,
      'unread_count': unreadCount,
      'is_group': isGroup,
      'is_online': isOnline,
      'initials': initials,
      'color_hex': colorHex,
      'messages': messages
          .map((m) => {
                'id': m.id,
                'sender_name': m.senderName,
                'text': m.text,
                'timestamp': m.timestamp,
                'is_me': m.isMe,
              })
          .toList(),
    };
  }
}
