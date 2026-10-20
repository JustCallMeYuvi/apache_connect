// import 'package:flutter/material.dart';
// import '../../core/constants/app_colors.dart';
// import '../../domain/entities/chat_conversation.dart';

// class ChatConversationView extends StatefulWidget {
//   final ChatConversation conversation;
//   final ValueChanged<String> onSendMessage;
//   final VoidCallback onClose;
//   final bool isDarkMode;
//   final bool isMobile;

//   const ChatConversationView({
//     super.key,
//     required this.conversation,
//     required this.onSendMessage,
//     required this.onClose,
//     this.isDarkMode = false,
//     this.isMobile = false,
//   });

//   @override
//   State<ChatConversationView> createState() => _ChatConversationViewState();
// }

// class _ChatConversationViewState extends State<ChatConversationView> {
//   final TextEditingController _messageController = TextEditingController();

//   void _send() {
//     final text = _messageController.text.trim();
//     if (text.isNotEmpty) {
//       widget.onSendMessage(text);
//       _messageController.clear();
//     }
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = widget.isDarkMode;
//     final conv = widget.conversation;

//     return Column(
//       children: [
//         // Header
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           decoration: BoxDecoration(
//             color: isDark ? const Color(0xFF1E293B) : Colors.white,
//             border: Border(
//               bottom: BorderSide(
//                 color: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
//                 width: 1,
//               ),
//             ),
//           ),
//           child: Row(
//             children: [
//               if (widget.isMobile)
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back_rounded),
//                   onPressed: widget.onClose,
//                   color: isDark ? Colors.white : AppColors.textDark,
//                   padding: EdgeInsets.zero,
//                   constraints: const BoxConstraints(),
//                 ),
//               if (widget.isMobile) const SizedBox(width: 12),

//               Container(
//                 width: 38,
//                 height: 38,
//                 decoration: BoxDecoration(
//                   color: Color(conv.colorHex),
//                   shape: BoxShape.circle,
//                 ),
//                 alignment: Alignment.center,
//                 child: conv.isGroup
//                     ? const Icon(Icons.groups_rounded, color: Colors.white, size: 20)
//                     : Text(
//                         conv.initials ?? '',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       conv.name,
//                       style: TextStyle(
//                         color: isDark ? Colors.white : AppColors.textDark,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     Text(
//                       conv.isGroup
//                           ? 'Group workspace · Active'
//                           : (conv.isOnline ? 'Online now' : 'Offline'),
//                       style: TextStyle(
//                         color: conv.isOnline ? AppColors.onlineGreen : const Color(0xFF94A3B8),
//                         fontSize: 11.5,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (!widget.isMobile)
//                 IconButton(
//                   icon: const Icon(Icons.close_rounded, size: 20),
//                   color: const Color(0xFF94A3B8),
//                   onPressed: widget.onClose,
//                 ),
//             ],
//           ),
//         ),

//         // Message List
//         Expanded(
//           child: Container(
//             color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF7F5F0),
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               itemCount: conv.messages.length,
//               itemBuilder: (context, index) {
//                 final msg = conv.messages[index];
//                 return Align(
//                   alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(vertical: 4),
//                     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                     constraints: const BoxConstraints(maxWidth: 380),
//                     decoration: BoxDecoration(
//                       color: msg.isMe
//                           ? AppColors.primaryOrange
//                           : (isDark ? const Color(0xFF1E293B) : Colors.white),
//                       borderRadius: BorderRadius.circular(14),
//                       border: msg.isMe
//                           ? null
//                           : Border.all(
//                               color: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
//                               width: 1,
//                             ),
//                       boxShadow: [
//                         BoxShadow(
//                           // color: Colors.black.withOpacity(0.03),
//                           color: Colors.black.withValues(alpha: 0.03),

//                           blurRadius: 4,
//                           offset: const Offset(0, 1),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment:
//                           msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                       children: [
//                         if (!msg.isMe && conv.isGroup)
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 2),
//                             child: Text(
//                               msg.senderName,
//                               style: TextStyle(
//                                 color: isDark ? Colors.amber : AppColors.primaryOrange,
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ),
//                         Text(
//                           msg.text,
//                           style: TextStyle(
//                             color: msg.isMe
//                                 ? Colors.white
//                                 : (isDark ? Colors.white : AppColors.textDark),
//                             fontSize: 13.5,
//                           ),
//                         ),
//                         const SizedBox(height: 3),
//                         Text(
//                           msg.timestamp,
//                           style: TextStyle(
//                             color: msg.isMe
//                                 // ? Colors.white.withOpacity(0.7)
//                                 ? Colors.white.withValues(alpha: 0.7)

//                                 : const Color(0xFF94A3B8),
//                             fontSize: 10,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),

//         // Bottom Input Box
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//           decoration: BoxDecoration(
//             color: isDark ? const Color(0xFF1E293B) : Colors.white,
//             border: Border(
//               top: BorderSide(
//                 color: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
//                 width: 1,
//               ),
//             ),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _messageController,
//                   onSubmitted: (_) => _send(),
//                   style: TextStyle(
//                     color: isDark ? Colors.white : AppColors.textDark,
//                     fontSize: 14,
//                   ),
//                   decoration: InputDecoration(
//                     hintText: 'Type a message to ${conv.name}...',
//                     hintStyle: const TextStyle(
//                       color: Color(0xFF94A3B8),
//                       fontSize: 13.5,
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide(
//                         color: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide(
//                         color: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: const BorderSide(color: AppColors.primaryOrange),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               IconButton(
//                 onPressed: _send,
//                 icon: const Icon(Icons.send_rounded),
//                 color: AppColors.primaryOrange,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// // today bloc comment
// import 'package:apache_connect/core/services/document_file_picker_service.dart';
// import 'package:apache_connect/presentation/bloc/messages/messages_bloc.dart';
// import 'package:apache_connect/presentation/bloc/messages/messages_event.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../core/constants/app_colors.dart';
// import '../../domain/entities/chat_conversation.dart';

// typedef SendMessageWithAttachment = void Function(
//   String message, {
//   String? attachmentName,
//   String? attachmentType,
//   int? attachmentSize,
//   String? attachmentUrl,
//   List<int>? attachmentBytes,
// });

// class ChatConversationView extends StatefulWidget {
//   final ChatConversation conversation;
//   final ValueChanged<String> onSendMessage;
//   final SendMessageWithAttachment? onSendWithAttachment;
//   final VoidCallback onClose;
//   final bool isDarkMode;
//   final bool isMobile;

//   const ChatConversationView({
//     super.key,
//     required this.conversation,
//     required this.onSendMessage,
//     this.onSendWithAttachment,
//     required this.onClose,
//     this.isDarkMode = false,
//     this.isMobile = false,
//   });

//   @override
//   State<ChatConversationView> createState() => _ChatConversationViewState();
// }

// class _ChatConversationViewState extends State<ChatConversationView> {
//   final TextEditingController _messageController = TextEditingController();

//   // PlatformFile? _selectedFile;
//   // List<int>? _selectedFileBytes;
//   // bool _isPickingFile = false;
//   // int? _selectedFileSize;

//   // Future<void> _pickAttachment() async {
//   //   try {
//   //     setState(() => _isPickingFile = true);

//   //     final result = await FilePicker.platform.pickFiles(
//   //       allowMultiple: false,
//   //       withData: true,
//   //     );

//   //     if (!mounted) return;

//   //     if (result != null && result.files.isNotEmpty) {
//   //       final file = result.files.single;

//   //       if (file.size > 5 * 1024 * 1024) {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           const SnackBar(
//   //             content: Text('Attachment must not exceed 5 MB.'),
//   //           ),
//   //         );
//   //         return;
//   //       }

//   //       setState(() => _selectedFile = file);
//   //     }
//   //   } catch (error) {
//   //     if (!mounted) return;

//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Unable to select file: $error')),
//   //     );
//   //   } finally {
//   //     if (mounted) {
//   //       setState(() => _isPickingFile = false);
//   //     }
//   //   }
//   // }
//  Future<void> _pickAttachment() async {
//   final bloc = context.read<MessagesBloc>();

//   bloc.add(const AttachmentPickingStartedEvent());

//   try {
//     final pickedFile = await FilePicker.pickFile(
//       type: FileType.custom,
//       allowedExtensions: DocumentFilePickerService.allowedExtensions,
//     );

//     if (pickedFile == null) return;

//     final bytes = await pickedFile.readAsBytes();

//     if (!mounted) return;

//     if (bytes.length > 5 * 1024 * 1024) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Attachment must not exceed 5 MB.'),
//         ),
//       );
//       return;
//     }

//     bloc.add(
//       AttachmentSelectedEvent(
//         name: pickedFile.name,
//         type: pickedFile.extension,
//         size: bytes.length,
//         bytes: bytes,
//       ),
//     );
//   } catch (error) {
//     if (!mounted) return;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Unable to select file: $error')),
//     );
//   } finally {
//     if (mounted) {
//       bloc.add(const AttachmentPickingFinishedEvent());
//     }
//   }
// }

//   // void _send() {
//   //   final text = _messageController.text.trim();
//   //   final file = _selectedFile;

//   //   if (text.isEmpty && file == null) return;

//   //   if (file != null && widget.onSendWithAttachment != null) {
//   //     widget.onSendWithAttachment!(
//   //       text,
//   //       attachmentName: file.name,
//   //       attachmentType: file.extension,
//   //       attachmentSize: _selectedFileSize,
//   //       attachmentUrl: null,
//   //     );
//   //   } else if (text.isNotEmpty) {
//   //     widget.onSendMessage(text);

//   //     if (file != null) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(
//   //           content: Text(
//   //             'Text sent, but attachment sending is not configured.',
//   //           ),
//   //         ),
//   //       );
//   //     }
//   //   }
//   // }

// void _send() {
//   final text = _messageController.text.trim();
//   final bloc = context.read<MessagesBloc>();
//   final state = bloc.state;

//   final hasAttachment = state.attachmentName != null &&
//       state.attachmentName!.trim().isNotEmpty;

//   if (text.isEmpty && !hasAttachment) return;

//   bloc.add(
//     SendMessageEvent(
//       text,
//       conversationId: widget.conversation.id,
//       attachmentName: state.attachmentName,
//       attachmentType: state.attachmentType,
//       attachmentSize: state.attachmentSize,
//       attachmentUrl: state.attachmentUrl,
//       attachmentBytes: state.attachmentBytes,
//     ),
//   );

//   _messageController.clear();
// }
//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = widget.isDarkMode;
//     final conv = widget.conversation;

//     final inputColor = isDark ? const Color(0xFF1E293B) : Colors.white;
//     final textColor = isDark ? Colors.white : AppColors.textDark;
//     final borderColor =
//         isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0);

//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 12,
//           ),
//           decoration: BoxDecoration(
//             color: inputColor,
//             border: Border(
//               bottom: BorderSide(color: borderColor),
//             ),
//           ),
//           child: Row(
//             children: [
//               if (widget.isMobile) ...[
//                 IconButton(
//                   onPressed: widget.onClose,
//                   icon: const Icon(Icons.arrow_back_rounded),
//                   color: textColor,
//                 ),
//                 const SizedBox(width: 4),
//               ],
//               CircleAvatar(
//                 backgroundColor: Color(conv.colorHex),
//                 child: conv.isGroup
//                     ? const Icon(
//                         Icons.groups_rounded,
//                         color: Colors.white,
//                       )
//                     : Text(
//                         conv.initials ?? '',
//                         style: const TextStyle(color: Colors.white),
//                       ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       conv.name,
//                       style: TextStyle(
//                         color: textColor,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     Text(
//                       conv.isGroup
//                           ? 'Group workspace · Active'
//                           : conv.isOnline
//                               ? 'Online now'
//                               : 'Offline',
//                       style: const TextStyle(
//                         color: Color(0xFF94A3B8),
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (!widget.isMobile)
//                 IconButton(
//                   onPressed: widget.onClose,
//                   icon: const Icon(Icons.close_rounded),
//                   color: const Color(0xFF94A3B8),
//                 ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Container(
//             color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF7F5F0),
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: conv.messages.length,
//               itemBuilder: (context, index) {
//                 final msg = conv.messages[index];

//                 return Align(
//                   alignment:
//                       msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     constraints: const BoxConstraints(maxWidth: 380),
//                     margin: const EdgeInsets.symmetric(vertical: 4),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       color: msg.isMe ? AppColors.primaryOrange : inputColor,
//                       borderRadius: BorderRadius.circular(14),
//                       border: msg.isMe ? null : Border.all(color: borderColor),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: msg.isMe
//                           ? CrossAxisAlignment.end
//                           : CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           msg.text,
//                           style: TextStyle(
//                             color: msg.isMe ? Colors.white : textColor,
//                             fontSize: 13.5,
//                           ),
//                         ),
//                         const SizedBox(height: 3),
//                         Text(
//                           msg.timestamp,
//                           style: const TextStyle(
//                             color: Color(0xFF94A3B8),
//                             fontSize: 10,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: inputColor,
//             border: Border(top: BorderSide(color: borderColor)),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // if (_selectedFile != null)
//               if (messageState.attachmentName != null)
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 8),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 8,
//                   ),
//                   decoration: BoxDecoration(
//                     color: isDark
//                         ? const Color(0xFF334155)
//                         : const Color(0xFFF7F5F0),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.attach_file_rounded,
//                         color: AppColors.primaryOrange,
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           _selectedFile!.name,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             color: textColor,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         '${((_selectedFileSize ?? 0) / 1024).toStringAsFixed(1)} KB',
//                         style: const TextStyle(
//                           color: Color(0xFF94A3B8),
//                           fontSize: 10,
//                         ),
//                       ),
//                       IconButton(
//                         tooltip: 'Remove attachment',
//                         onPressed: () {
//                           // setState(() => _selectedFile = null);
//                           context.read<MessagesBloc>().add(
//                                 const AttachmentRemovedEvent(),
//                               );
//                         },
//                         icon: const Icon(Icons.close, size: 18),
//                       ),
//                     ],
//                   ),
//                 ),
//               Row(
//                 children: [
//                   IconButton(
//                     tooltip: 'Attach file',
//                     onPressed: _isPickingFile ? null : _pickAttachment,
//                     icon: _isPickingFile
//                         ? const SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                             ),
//                           )
//                         : const Icon(Icons.attach_file_rounded),
//                     color: AppColors.primaryOrange,
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       onSubmitted: (_) => _send(),
//                       style: TextStyle(color: textColor),
//                       decoration: InputDecoration(
//                         hintText: 'Type a message to ${conv.name}...',
//                         hintStyle: const TextStyle(
//                           color: Color(0xFF94A3B8),
//                           fontSize: 13,
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 14,
//                           vertical: 10,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                           borderSide: BorderSide(color: borderColor),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                           borderSide: BorderSide(color: borderColor),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                           borderSide: const BorderSide(
//                             color: AppColors.primaryOrange,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   IconButton(
//                     onPressed: _send,
//                     icon: const Icon(Icons.send_rounded),
//                     color: AppColors.primaryOrange,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:apache_connect/core/constants/app_colors.dart';
import 'package:apache_connect/core/services/document_file_picker_service.dart';
import 'package:apache_connect/domain/entities/chat_conversation.dart';
import 'package:apache_connect/presentation/bloc/messages/messages_bloc.dart';
import 'package:apache_connect/presentation/bloc/messages/messages_event.dart';
import 'package:apache_connect/presentation/bloc/messages/messages_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef SendMessageWithAttachment = void Function(
  String message, {
  String? attachmentName,
  String? attachmentType,
  int? attachmentSize,
  String? attachmentUrl,
  List<int>? attachmentBytes,
});

class ChatConversationView extends StatefulWidget {
  final ChatConversation conversation;
  final ValueChanged<String> onSendMessage;
  final SendMessageWithAttachment? onSendWithAttachment;
  final VoidCallback onClose;
  final bool isDarkMode;
  final bool isMobile;

  const ChatConversationView({
    super.key,
    required this.conversation,
    required this.onSendMessage,
    this.onSendWithAttachment,
    required this.onClose,
    this.isDarkMode = false,
    this.isMobile = false,
  });

  @override
  State<ChatConversationView> createState() => _ChatConversationViewState();
}

class _ChatConversationViewState extends State<ChatConversationView> {
  final TextEditingController _messageController = TextEditingController();

  Future<void> _pickAttachment() async {
    final bloc = context.read<MessagesBloc>();

    bloc.add(const AttachmentPickingStartedEvent());

    try {
      final pickedFile = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: DocumentFilePickerService.allowedExtensions,
      );

      if (!mounted || pickedFile == null) return;

      final bytes = await pickedFile.readAsBytes();

      if (!mounted) return;

      if (bytes.length > 5 * 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Attachment must not exceed 5 MB.'),
          ),
        );
        return;
      }

      bloc.add(
        AttachmentSelectedEvent(
          name: pickedFile.name,
          type: pickedFile.extension,
          size: bytes.length,
          bytes: bytes,
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to select file: $error'),
        ),
      );
    } finally {
      if (mounted) {
        bloc.add(const AttachmentPickingFinishedEvent());
      }
    }
  }

  void _send() {
    final text = _messageController.text.trim();
    final bloc = context.read<MessagesBloc>();
    final state = bloc.state;

    final attachmentName = state.attachmentName;
    final hasAttachment =
        attachmentName != null && attachmentName.trim().isNotEmpty;

    if (text.isEmpty && !hasAttachment) return;

    bloc.add(
      SendMessageEvent(
        text,
        conversationId: widget.conversation.id,
        attachmentName: state.attachmentName,
        attachmentType: state.attachmentType,
        attachmentSize: state.attachmentSize,
        attachmentUrl: null,
        attachmentBytes: state.attachmentBytes,
      ),
    );

    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final conv = widget.conversation;

    final inputColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.textDark;
    final borderColor =
        isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0);

    return BlocBuilder<MessagesBloc, MessagesState>(
      builder: (context, messageState) {
        return Column(
          children: [
            // Conversation header
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: inputColor,
                border: Border(
                  bottom: BorderSide(color: borderColor),
                ),
              ),
              child: Row(
                children: [
                  if (widget.isMobile) ...[
                    IconButton(
                      onPressed: widget.onClose,
                      icon: const Icon(Icons.arrow_back_rounded),
                      color: textColor,
                    ),
                    const SizedBox(width: 4),
                  ],
                  CircleAvatar(
                    backgroundColor: Color(conv.colorHex),
                    child: conv.isGroup
                        ? const Icon(
                            Icons.groups_rounded,
                            color: Colors.white,
                          )
                        : Text(
                            conv.initials ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          conv.name,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          conv.isGroup
                              ? 'Group workspace · Active'
                              : conv.isOnline
                                  ? 'Online now'
                                  : 'Offline',
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!widget.isMobile)
                    IconButton(
                      onPressed: widget.onClose,
                      icon: const Icon(Icons.close_rounded),
                      color: const Color(0xFF94A3B8),
                    ),
                ],
              ),
            ),

            // Messages
            Expanded(
              child: Container(
                color:
                    isDark ? const Color(0xFF0F172A) : const Color(0xFFF7F5F0),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: conv.messages.length,
                  itemBuilder: (context, index) {
                    final msg = conv.messages[index];

                    return Align(
                      alignment: msg.isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 380),
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color:
                              msg.isMe ? AppColors.primaryOrange : inputColor,
                          borderRadius: BorderRadius.circular(14),
                          border:
                              msg.isMe ? null : Border.all(color: borderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: msg.isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            if (msg.text.trim().isNotEmpty)
                              Text(
                                msg.text,
                                style: TextStyle(
                                  color: msg.isMe ? Colors.white : textColor,
                                  fontSize: 13.5,
                                ),
                              ),

                            // Attachment displayed in the message
                            if (msg.attachmentName != null &&
                                msg.attachmentName!.trim().isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: msg.isMe
                                      ? Colors.white.withValues(
                                          alpha: 0.15,
                                        )
                                      : (isDark
                                          ? const Color(0xFF334155)
                                          : const Color(0xFFF1F5F9)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.insert_drive_file_rounded,
                                      color: msg.isMe
                                          ? Colors.white
                                          : AppColors.primaryOrange,
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              maxWidth: 230,
                                            ),
                                            child: Text(
                                              msg.attachmentName!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: msg.isMe
                                                    ? Colors.white
                                                    : textColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          if (msg.attachmentSize != null)
                                            Text(
                                              '${(msg.attachmentSize! / 1024).toStringAsFixed(1)} KB',
                                              style: TextStyle(
                                                color: msg.isMe
                                                    ? Colors.white70
                                                    : const Color(
                                                        0xFF94A3B8,
                                                      ),
                                                fontSize: 10,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],

                            const SizedBox(height: 3),
                            Text(
                              msg.timestamp,
                              style: const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Message composer and attachment preview
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: inputColor,
                border: Border(
                  top: BorderSide(color: borderColor),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (messageState.attachmentName != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF334155)
                            : const Color(0xFFF7F5F0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.attach_file_rounded,
                            color: AppColors.primaryOrange,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              messageState.attachmentName!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            '${((messageState.attachmentSize ?? 0) / 1024).toStringAsFixed(1)} KB',
                            style: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 10,
                            ),
                          ),
                          IconButton(
                            tooltip: 'Remove attachment',
                            onPressed: () {
                              context.read<MessagesBloc>().add(
                                    const AttachmentRemovedEvent(),
                                  );
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    children: [
                      IconButton(
                        tooltip: 'Attach file',
                        onPressed: messageState.isPickingAttachment
                            ? null
                            : _pickAttachment,
                        icon: messageState.isPickingAttachment
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.attach_file_rounded),
                        color: AppColors.primaryOrange,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          onSubmitted: (_) => _send(),
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            hintText: 'Type a message to ${conv.name}...',
                            hintStyle: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 13,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: borderColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: borderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: AppColors.primaryOrange,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: _send,
                        icon: const Icon(Icons.send_rounded),
                        color: AppColors.primaryOrange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
