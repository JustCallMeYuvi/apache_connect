import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_result.dart';
import '../../../domain/entities/chat_conversation.dart';
import '../../../domain/usecases/create_group_usecase.dart';
import '../../../domain/usecases/get_conversations_usecase.dart';
import '../../../domain/usecases/send_message_usecase.dart';
import 'messages_event.dart';
import 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final GetConversationsUseCase _getConversationsUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final CreateGroupUseCase _createGroupUseCase;

  MessagesBloc({
    required GetConversationsUseCase getConversationsUseCase,
    required SendMessageUseCase sendMessageUseCase,
    required CreateGroupUseCase createGroupUseCase,
  })  : _getConversationsUseCase = getConversationsUseCase,
        _sendMessageUseCase = sendMessageUseCase,
        _createGroupUseCase = createGroupUseCase,
        super(const MessagesState()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<FilterTabChangedEvent>(_onFilterTabChanged);
    on<SearchQueryChangedEvent>(_onSearchQueryChanged);
    on<SelectConversationEvent>(_onSelectConversation);
    // on<ClearSelectedConversationEvent>(_onClearSelectedConversation);
    // on<SendMessageEvent>(_onSendMessage);
    // on<CreateGroupEvent>(_onCreateGroup);
    on<ClearSelectedConversationEvent>(_onClearSelectedConversation);
    on<SendMessageEvent>(_onSendMessage);
    on<CreateGroupEvent>(_onCreateGroup);

    on<AttachmentPickingStartedEvent>((event, emit) {
      emit(state.copyWith(isPickingAttachment: true));
    });

    on<AttachmentSelectedEvent>((event, emit) {
      emit(
        state.copyWith(
          attachmentName: event.name,
          attachmentType: event.type,
          attachmentSize: event.size,
          attachmentBytes: event.bytes,
          isPickingAttachment: false,
        ),
      );
    });

    on<AttachmentRemovedEvent>((event, emit) {
      emit(
        state.copyWith(
          clearAttachment: true,
          isPickingAttachment: false,
        ),
      );
    });

    on<AttachmentPickingFinishedEvent>((event, emit) {
      emit(state.copyWith(isPickingAttachment: false));
    });
  }

  Future<void> _onLoadMessages(
    LoadMessagesEvent event,
    Emitter<MessagesState> emit,
  ) async {
    emit(state.copyWith(status: MessagesStatus.loading));

    final result = await _getConversationsUseCase.execute();

    if (result is Success<List<ChatConversation>>) {
      final conversations = result.data;
      final filtered = _applyFilterAndSearch(
        conversations: conversations,
        filter: state.selectedFilter,
        query: state.searchQuery,
      );

      emit(state.copyWith(
        status: MessagesStatus.success,
        allConversations: conversations,
        filteredConversations: filtered,
      ));
    } else if (result is Failure<List<ChatConversation>>) {
      emit(state.copyWith(
        status: MessagesStatus.failure,
        errorMessage: result.errorMessage,
      ));
    }
  }

  void _onFilterTabChanged(
    FilterTabChangedEvent event,
    Emitter<MessagesState> emit,
  ) {
    final filtered = _applyFilterAndSearch(
      conversations: state.allConversations,
      filter: event.filter,
      query: state.searchQuery,
    );

    emit(state.copyWith(
      selectedFilter: event.filter,
      filteredConversations: filtered,
    ));
  }

  void _onSearchQueryChanged(
    SearchQueryChangedEvent event,
    Emitter<MessagesState> emit,
  ) {
    final filtered = _applyFilterAndSearch(
      conversations: state.allConversations,
      filter: state.selectedFilter,
      query: event.query,
    );

    emit(state.copyWith(
      searchQuery: event.query,
      filteredConversations: filtered,
    ));
  }

  void _onSelectConversation(
    SelectConversationEvent event,
    Emitter<MessagesState> emit,
  ) {
    // When a conversation is selected, mark its unread as cleared
    final updatedList = state.allConversations.map((c) {
      if (c.id == event.conversationId) {
        return c.copyWith(unreadCount: 0);
      }
      return c;
    }).toList();

    final filtered = _applyFilterAndSearch(
      conversations: updatedList,
      filter: state.selectedFilter,
      query: state.searchQuery,
    );

    emit(state.copyWith(
      allConversations: updatedList,
      filteredConversations: filtered,
      selectedConversationId: event.conversationId,
    ));
  }

  void _onClearSelectedConversation(
    ClearSelectedConversationEvent event,
    Emitter<MessagesState> emit,
  ) {
    emit(state.copyWith(clearSelected: true));
  }

  // Future<void> _onSendMessage(
  //   SendMessageEvent event,
  //   Emitter<MessagesState> emit,
  // ) async {
  //   final currentConvId = state.selectedConversationId;
  //   if (currentConvId == null || event.text.trim().isEmpty) return;

  //   await _sendMessageUseCase.execute(
  //     conversationId: currentConvId,
  //     text: event.text.trim(),
  //   );

  //   // Refresh conversations
  //   add(const LoadMessagesEvent());
  // }
 
 Future<void> _onSendMessage(
  SendMessageEvent event,
  Emitter<MessagesState> emit,
) async {
  final text = event.text.trim();

  final hasAttachment = event.attachmentName != null &&
      event.attachmentName!.trim().isNotEmpty;

  if (text.isEmpty && !hasAttachment) return;

  final result = await _sendMessageUseCase.execute(
    conversationId: event.conversationId,
    text: text,
    attachmentName: event.attachmentName,
    attachmentType: event.attachmentType,
    attachmentSize: event.attachmentSize,
    attachmentUrl: event.attachmentUrl,
    attachmentBytes: event.attachmentBytes,
  );

  if (result is Failure<void>) {
    emit(state.copyWith(errorMessage: result.errorMessage));
    return;
  }

  emit(state.copyWith(clearAttachment: true));
  add(const LoadMessagesEvent());
}



  Future<void> _onCreateGroup(
    CreateGroupEvent event,
    Emitter<MessagesState> emit,
  ) async {
    if (event.name.trim().isEmpty) return;

    final result = await _createGroupUseCase.execute(
      name: event.name.trim(),
      memberNames: event.memberNames,
    );

    if (result is Success<ChatConversation>) {
      final updatedList = List<ChatConversation>.from(state.allConversations)
        ..insert(0, result.data);

      final filtered = _applyFilterAndSearch(
        conversations: updatedList,
        filter: state.selectedFilter,
        query: state.searchQuery,
      );

      emit(state.copyWith(
        allConversations: updatedList,
        filteredConversations: filtered,
        selectedConversationId: result.data.id,
      ));
    }
  }

  List<ChatConversation> _applyFilterAndSearch({
    required List<ChatConversation> conversations,
    required ChatFilterType filter,
    required String query,
  }) {
    var result = conversations;

    // Apply Filter Tab (All, Direct, Groups)
    if (filter == ChatFilterType.direct) {
      result = result.where((c) => !c.isGroup).toList();
    } else if (filter == ChatFilterType.groups) {
      result = result.where((c) => c.isGroup).toList();
    }

    // Apply Search Query
    if (query.trim().isNotEmpty) {
      final q = query.toLowerCase().trim();
      result = result.where((c) {
        return c.name.toLowerCase().contains(q) ||
            c.lastMessage.toLowerCase().contains(q);
      }).toList();
    }

    return result;
  }
}
