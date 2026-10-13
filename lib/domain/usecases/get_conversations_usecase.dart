import '../../core/network/api_result.dart';
import '../entities/chat_conversation.dart';
import '../repositories/messages_repository.dart';

class GetConversationsUseCase {
  final MessagesRepository _repository;

  GetConversationsUseCase(this._repository);

  Future<ApiResult<List<ChatConversation>>> execute() async {
    return await _repository.getConversations();
  }
}
