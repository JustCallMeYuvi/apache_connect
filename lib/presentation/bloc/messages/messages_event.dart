import 'package:equatable/equatable.dart';
import '../../../domain/entities/chat_conversation.dart';

abstract class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object?> get props => [];
}

class LoadMessagesEvent extends MessagesEvent {
  const LoadMessagesEvent();
}

class FilterTabChangedEvent extends MessagesEvent {
  final ChatFilterType filter;
  const FilterTabChangedEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

class SearchQueryChangedEvent extends MessagesEvent {
  final String query;
  const SearchQueryChangedEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class SelectConversationEvent extends MessagesEvent {
  final String conversationId;
  const SelectConversationEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class ClearSelectedConversationEvent extends MessagesEvent {
  const ClearSelectedConversationEvent();
}

// class SendMessageEvent extends MessagesEvent {
//   final String text;
//   const SendMessageEvent(this.text);

//   @override
//   List<Object?> get props => [text];
// }


class SendMessageEvent extends MessagesEvent {
  final String conversationId;
  final String text;
  final String? attachmentName;
  final String? attachmentType;
  final int? attachmentSize;
  final String? attachmentUrl;
  final List<int>? attachmentBytes;

  const SendMessageEvent(
    this.text, {
    required this.conversationId,
    this.attachmentName,
    this.attachmentType,
    this.attachmentSize,
    this.attachmentUrl,
    this.attachmentBytes,
  });

  @override
  List<Object?> get props => [
        conversationId,
        text,
        attachmentName,
        attachmentType,
        attachmentSize,
        attachmentUrl,
        attachmentBytes,
      ];
}


class CreateGroupEvent extends MessagesEvent {
  final String name;
  final List<String> memberNames;
  const CreateGroupEvent({required this.name, this.memberNames = const []});

  @override
  List<Object?> get props => [name, memberNames];
}


class AttachmentPickingStartedEvent extends MessagesEvent {
  const AttachmentPickingStartedEvent();
}

class AttachmentSelectedEvent extends MessagesEvent {
  final String name;
  final String? type;
  final int size;
  final List<int> bytes;

  const AttachmentSelectedEvent({
    required this.name,
    required this.type,
    required this.size,
    required this.bytes,
  });

  @override
  List<Object?> get props => [name, type, size, bytes];
}

class AttachmentRemovedEvent extends MessagesEvent {
  const AttachmentRemovedEvent();
}

class AttachmentPickingFinishedEvent extends MessagesEvent {
  const AttachmentPickingFinishedEvent();
}

