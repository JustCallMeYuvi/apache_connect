import '../../core/network/api_result.dart';
import '../entities/chat_conversation.dart';

abstract class MessagesRepository {
  Future<ApiResult<List<ChatConversation>>> getConversations();

  // Future<ApiResult<void>> sendMessage({
  //   required String conversationId,
  //   required String text,
  // });

Future<ApiResult<void>> sendMessage({
  required String conversationId,
  required String text,
  String? attachmentName,
  String? attachmentType,
  int? attachmentSize,
  String? attachmentUrl,
  List<int>? attachmentBytes,
});

  Future<ApiResult<ChatConversation>> createGroup({
    required String name,
    required List<String> memberNames,
  });
}
