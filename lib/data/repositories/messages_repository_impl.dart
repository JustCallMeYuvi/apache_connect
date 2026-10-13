import 'package:apache_connect/domain/repositories/messages_repository.dart';

import '../../core/network/api_result.dart';
import '../../domain/entities/chat_conversation.dart';
import '../datasources/messages_remote_data_source.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  final MessagesRemoteDataSource remoteDataSource;

  MessagesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<ChatConversation>>> getConversations() async {
    try {
      final conversations = await remoteDataSource.fetchConversations();
      return Success(conversations);
    } catch (e) {
      return Failure(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<ApiResult<void>> sendMessage({
    required String conversationId,
    required String text,
  }) async {
    try {
      await remoteDataSource.sendMessage(
        conversationId: conversationId,
        text: text,
      );
      return const Success(null);
    } catch (e) {
      return Failure(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<ApiResult<ChatConversation>> createGroup({
    required String name,
    required List<String> memberNames,
  }) async {
    try {
      final group = await remoteDataSource.createGroup(
        name: name,
        memberNames: memberNames,
      );
      return Success(group);
    } catch (e) {
      return Failure(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
