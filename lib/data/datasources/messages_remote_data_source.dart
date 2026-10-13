import '../models/chat_conversation_model.dart';

abstract class MessagesRemoteDataSource {
  Future<List<ChatConversationModel>> fetchConversations();
  Future<void> sendMessage({required String conversationId, required String text});
  Future<ChatConversationModel> createGroup({required String name, required List<String> memberNames});
}

class MessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  List<ChatConversationModel> _cachedConversations = [];

  MessagesRemoteDataSourceImpl() {
    _initInitialData();
  }

  void _initInitialData() {
    _cachedConversations = [
      const ChatConversationModel(
        id: 'chat_safety_committee',
        name: 'Safety Committee',
        lastMessage: 'Sounds good.',
        time: '02:48 PM',
        unreadCount: 85,
        isGroup: true,
        isOnline: false,
        initials: null,
        colorHex: 0xFF9A3412, // Rust brown group avatar
        messages: [
          ChatMessageModel(
            id: 'm1',
            senderName: 'Safety Officer',
            text: 'Please review the updated safety audit protocols before Friday.',
            timestamp: '02:30 PM',
            isMe: false,
          ),
          ChatMessageModel(
            id: 'm2',
            senderName: 'Syed Imran',
            text: 'I will review with the factory heads today.',
            timestamp: '02:42 PM',
            isMe: true,
          ),
          ChatMessageModel(
            id: 'm3',
            senderName: 'Safety Committee',
            text: 'Sounds good.',
            timestamp: '02:48 PM',
            isMe: false,
          ),
        ],
      ),
      const ChatConversationModel(
        id: 'chat_finance_team',
        name: 'Finance Team',
        lastMessage: 'Sure, will do.',
        time: '02:45 PM',
        unreadCount: 56,
        isGroup: true,
        isOnline: false,
        initials: null,
        colorHex: 0xFF0D9488, // Teal group avatar
        messages: [
          ChatMessageModel(
            id: 'm4',
            senderName: 'Finance Lead',
            text: 'Quarterly variance reports have been consolidated.',
            timestamp: '02:10 PM',
            isMe: false,
          ),
          ChatMessageModel(
            id: 'm5',
            senderName: 'Syed Imran',
            text: 'Please attach the factory machinery depreciation sheet.',
            timestamp: '02:35 PM',
            isMe: true,
          ),
          ChatMessageModel(
            id: 'm6',
            senderName: 'Finance Team',
            text: 'Sure, will do.',
            timestamp: '02:45 PM',
            isMe: false,
          ),
        ],
      ),
      const ChatConversationModel(
        id: 'chat_anita_sharma',
        name: 'Anita Sharma',
        lastMessage: 'Can we discuss this in the afternoon?',
        time: '02:36 PM',
        unreadCount: 5,
        isGroup: false,
        isOnline: true,
        initials: 'AS',
        colorHex: 0xFF6366F1, // Purple avatar
        messages: [
          ChatMessageModel(
            id: 'm7',
            senderName: 'Anita Sharma',
            text: 'Hey Syed, did you check the vendor onboarding contracts?',
            timestamp: '02:15 PM',
            isMe: false,
          ),
          ChatMessageModel(
            id: 'm8',
            senderName: 'Anita Sharma',
            text: 'Can we discuss this in the afternoon?',
            timestamp: '02:36 PM',
            isMe: false,
          ),
        ],
      ),
      const ChatConversationModel(
        id: 'chat_ravi_kumar',
        name: 'Ravi Kumar',
        lastMessage: 'Got it 👍',
        time: '02:29 PM',
        unreadCount: 12,
        isGroup: false,
        isOnline: true,
        initials: 'RK',
        colorHex: 0xFF115E59, // Dark teal avatar
        messages: [
          ChatMessageModel(
            id: 'm9',
            senderName: 'Syed Imran',
            text: 'Ravi, please verify the logistics manifest for Pune factory shipment.',
            timestamp: '02:20 PM',
            isMe: true,
          ),
          ChatMessageModel(
            id: 'm10',
            senderName: 'Ravi Kumar',
            text: 'Got it 👍',
            timestamp: '02:29 PM',
            isMe: false,
          ),
        ],
      ),
    ];
  }

  @override
  Future<List<ChatConversationModel>> fetchConversations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_cachedConversations);
  }

  @override
  Future<void> sendMessage({required String conversationId, required String text}) async {
    final index = _cachedConversations.indexWhere((c) => c.id == conversationId);
    if (index != -1) {
      final conv = _cachedConversations[index];
      final newMsg = ChatMessageModel(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        senderName: 'Syed Imran',
        text: text,
        timestamp: 'Just now',
        isMe: true,
      );
      final updatedMessages = List<ChatMessageModel>.from(conv.messages)..add(newMsg);
      _cachedConversations[index] = ChatConversationModel(
        id: conv.id,
        name: conv.name,
        lastMessage: text,
        time: 'Just now',
        unreadCount: 0,
        isGroup: conv.isGroup,
        isOnline: conv.isOnline,
        initials: conv.initials,
        colorHex: conv.colorHex,
        messages: updatedMessages,
      );
    }
  }

  @override
  Future<ChatConversationModel> createGroup({
    required String name,
    required List<String> memberNames,
  }) async {
    final newGroup = ChatConversationModel(
      id: 'group_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      lastMessage: 'Group created',
      time: 'Just now',
      unreadCount: 0,
      isGroup: true,
      isOnline: false,
      initials: null,
      colorHex: 0xFFEA580C,
      messages: [
        ChatMessageModel(
          id: 'init_m',
          senderName: 'System',
          text: 'Group "$name" created by Syed Imran',
          timestamp: 'Just now',
          isMe: false,
        ),
      ],
    );
    _cachedConversations.insert(0, newGroup);
    return newGroup;
  }
}
