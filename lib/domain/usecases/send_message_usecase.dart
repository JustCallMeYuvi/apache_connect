import '../../core/network/api_result.dart';
import '../repositories/messages_repository.dart';

class SendMessageUseCase {
  final MessagesRepository _repository;

  SendMessageUseCase(this._repository);

  Future<ApiResult<void>> execute({
    required String conversationId,
    required String text,
  }) async {
    return await _repository.sendMessage(
      conversationId: conversationId,
      text: text,
    );
  }
}
