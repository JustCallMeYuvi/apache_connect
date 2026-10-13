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

class SendMessageEvent extends MessagesEvent {
  final String text;
  const SendMessageEvent(this.text);

  @override
  List<Object?> get props => [text];
}

class CreateGroupEvent extends MessagesEvent {
  final String name;
  final List<String> memberNames;
  const CreateGroupEvent({required this.name, this.memberNames = const []});

  @override
  List<Object?> get props => [name, memberNames];
}
