import 'package:equatable/equatable.dart';

enum ChatFilterType { all, direct, groups }

// class ChatMessage extends Equatable {
//   final String id;
//   final String senderName;
//   final String text;
//   final String timestamp;
//   final bool isMe;

//   const ChatMessage({
//     required this.id,
//     required this.senderName,
//     required this.text,
//     required this.timestamp,
//     required this.isMe,
//   });

//   @override
//   List<Object?> get props => [id, senderName, text, timestamp, isMe];
// }

class ChatMessage extends Equatable {
  final String id;
  final String senderName;
  final String text;
  final String timestamp;
  final bool isMe;

  // Attachment metadata
  final String? attachmentName;
  final String? attachmentType;
  final int? attachmentSize;
  final String? attachmentUrl;
  final List<int>? attachmentBytes;

  const ChatMessage({
    required this.id,
    required this.senderName,
    required this.text,
    required this.timestamp,
    required this.isMe,
    this.attachmentName,
    this.attachmentType,
    this.attachmentSize,
    this.attachmentUrl,
    this.attachmentBytes,
  });

  bool get hasAttachment =>
      attachmentName != null && attachmentName!.trim().isNotEmpty;

  String get formattedAttachmentSize {
    final size = attachmentSize ?? 0;

    if (size >= 1024 * 1024) {
      return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
    }

    return '${(size / 1024).toStringAsFixed(1)} KB';
  }

  @override
  List<Object?> get props => [
        id,
        senderName,
        text,
        timestamp,
        isMe,
        attachmentName,
        attachmentType,
        attachmentSize,
        attachmentUrl,
               attachmentBytes,
      ];
}

class ChatConversation extends Equatable {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isGroup;
  final bool isOnline;
  final String? initials;
  final int colorHex;
  final List<ChatMessage> messages;

  const ChatConversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isGroup,
    this.isOnline = false,
    this.initials,
    required this.colorHex,
    this.messages = const [],
  });

  ChatConversation copyWith({
    String? id,
    String? name,
    String? lastMessage,
    String? time,
    int? unreadCount,
    bool? isGroup,
    bool? isOnline,
    String? initials,
    int? colorHex,
    List<ChatMessage>? messages,
  }) {
    return ChatConversation(
      id: id ?? this.id,
      name: name ?? this.name,
      lastMessage: lastMessage ?? this.lastMessage,
      time: time ?? this.time,
      unreadCount: unreadCount ?? this.unreadCount,
      isGroup: isGroup ?? this.isGroup,
      isOnline: isOnline ?? this.isOnline,
      initials: initials ?? this.initials,
      colorHex: colorHex ?? this.colorHex,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        lastMessage,
        time,
        unreadCount,
        isGroup,
        isOnline,
        initials,
        colorHex,
        messages,
      ];
}
