import '../../core/network/api_result.dart';
import '../entities/chat_conversation.dart';

abstract class MessagesRepository {
  Future<ApiResult<List<ChatConversation>>> getConversations();

  Future<ApiResult<void>> sendMessage({
    required String conversationId,
    required String text,
  });

  Future<ApiResult<ChatConversation>> createGroup({
    required String name,
    required List<String> memberNames,
  });
}
