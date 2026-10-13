import '../../core/network/api_result.dart';
import '../entities/chat_conversation.dart';
import '../repositories/messages_repository.dart';

class CreateGroupUseCase {
  final MessagesRepository _repository;

  CreateGroupUseCase(this._repository);

  Future<ApiResult<ChatConversation>> execute({
    required String name,
    required List<String> memberNames,
  }) async {
    return await _repository.createGroup(
      name: name,
      memberNames: memberNames,
    );
  }
}
