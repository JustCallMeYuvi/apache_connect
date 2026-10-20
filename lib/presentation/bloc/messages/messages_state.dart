// import 'package:equatable/equatable.dart';
// import '../../../domain/entities/chat_conversation.dart';

// enum MessagesStatus { initial, loading, success, failure }

// class MessagesState extends Equatable {
//   final MessagesStatus status;
//   final List<ChatConversation> allConversations;
//   final List<ChatConversation> filteredConversations;
//   final ChatFilterType selectedFilter;
//   final String searchQuery;
//   final String? selectedConversationId;
//   final String? errorMessage;

//   const MessagesState({
//     this.status = MessagesStatus.initial,
//     this.allConversations = const [],
//     this.filteredConversations = const [],
//     this.selectedFilter = ChatFilterType.all,
//     this.searchQuery = '',
//     this.selectedConversationId,
//     this.errorMessage,
//   });

//   bool get isLoading => status == MessagesStatus.loading;
//   bool get isSuccess => status == MessagesStatus.success;
//   bool get isFailure => status == MessagesStatus.failure;

//   ChatConversation? get selectedConversation {
//     if (selectedConversationId == null) return null;
//     try {
//       return allConversations.firstWhere((c) => c.id == selectedConversationId);
//     } catch (_) {
//       return null;
//     }
//   }

//   int get totalUnreadMessages {
//     return allConversations.fold(0, (sum, item) => sum + item.unreadCount);
//   }

//   MessagesState copyWith({
//     MessagesStatus? status,
//     List<ChatConversation>? allConversations,
//     List<ChatConversation>? filteredConversations,
//     ChatFilterType? selectedFilter,
//     String? searchQuery,
//     String? selectedConversationId,
//     bool clearSelected = false,
//     String? errorMessage,
//   }) {
//     return MessagesState(
//       status: status ?? this.status,
//       allConversations: allConversations ?? this.allConversations,
//       filteredConversations: filteredConversations ?? this.filteredConversations,
//       selectedFilter: selectedFilter ?? this.selectedFilter,
//       searchQuery: searchQuery ?? this.searchQuery,
//       selectedConversationId: clearSelected
//           ? null
//           : (selectedConversationId ?? this.selectedConversationId),
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         status,
//         allConversations,
//         filteredConversations,
//         selectedFilter,
//         searchQuery,
//         selectedConversationId,
//         errorMessage,
//       ];
// }



import 'package:equatable/equatable.dart';
import '../../../domain/entities/chat_conversation.dart';

enum MessagesStatus { initial, loading, success, failure }

class MessagesState extends Equatable {
  final MessagesStatus status;
  final List<ChatConversation> allConversations;
  final List<ChatConversation> filteredConversations;
  final ChatFilterType selectedFilter;
  final String searchQuery;
  final String? selectedConversationId;
  final String? errorMessage;

  // Attachment state
  final String? attachmentName;
  final String? attachmentType;
  final int? attachmentSize;
  final List<int>? attachmentBytes;
  final bool isPickingAttachment;

  const MessagesState({
    this.status = MessagesStatus.initial,
    this.allConversations = const [],
    this.filteredConversations = const [],
    this.selectedFilter = ChatFilterType.all,
    this.searchQuery = '',
    this.selectedConversationId,
    this.errorMessage,
    this.attachmentName,
    this.attachmentType,
    this.attachmentSize,
    this.attachmentBytes,
    this.isPickingAttachment = false,
  });

  bool get isLoading => status == MessagesStatus.loading;
  bool get isSuccess => status == MessagesStatus.success;
  bool get isFailure => status == MessagesStatus.failure;

  ChatConversation? get selectedConversation {
    if (selectedConversationId == null) return null;

    try {
      return allConversations.firstWhere(
        (c) => c.id == selectedConversationId,
      );
    } catch (_) {
      return null;
    }
  }

  int get totalUnreadMessages {
    return allConversations.fold(
      0,
      (sum, item) => sum + item.unreadCount,
    );
  }

  MessagesState copyWith({
    MessagesStatus? status,
    List<ChatConversation>? allConversations,
    List<ChatConversation>? filteredConversations,
    ChatFilterType? selectedFilter,
    String? searchQuery,
    String? selectedConversationId,
    bool clearSelected = false,
    String? errorMessage,
    String? attachmentName,
    String? attachmentType,
    int? attachmentSize,
    List<int>? attachmentBytes,
    bool isPickingAttachment = false,
    bool clearAttachment = false,
  }) {
    return MessagesState(
      status: status ?? this.status,
      allConversations:
          allConversations ?? this.allConversations,
      filteredConversations:
          filteredConversations ?? this.filteredConversations,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedConversationId: clearSelected
          ? null
          : selectedConversationId ?? this.selectedConversationId,
      errorMessage: errorMessage ?? this.errorMessage,
      attachmentName:
          clearAttachment ? null : attachmentName ?? this.attachmentName,
      attachmentType:
          clearAttachment ? null : attachmentType ?? this.attachmentType,
      attachmentSize:
          clearAttachment ? null : attachmentSize ?? this.attachmentSize,
      attachmentBytes:
          clearAttachment ? null : attachmentBytes ?? this.attachmentBytes,
      isPickingAttachment: isPickingAttachment,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allConversations,
        filteredConversations,
        selectedFilter,
        searchQuery,
        selectedConversationId,
        errorMessage,
        attachmentName,
        attachmentType,
        attachmentSize,
        attachmentBytes,
        isPickingAttachment,
      ];
}
