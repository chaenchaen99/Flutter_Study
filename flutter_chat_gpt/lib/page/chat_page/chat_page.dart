import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/hive_model/chat_item_model.dart';
import 'package:flutter_chat_gpt/page/chat_page/widgets/chat_input.dart';

class ChatPage extends StatelessWidget {
  final ChatItemModel chatItem;
  const ChatPage({super.key, required this.chatItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room'),
      ),
      body: ChatInput(
        onSend: (message) {},
        isLoading: false,
      ),
    );
  }
}
