import 'package:flutter/material.dart';

import '../CustomUi/custom_card.dart';
import '../models/chat_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key, required this.chatmodels, required this.sourceChat});
  final List<ChatModel> chatmodels;
  final ChatModel sourceChat;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (context, index) => CustomCard(
          sourceChat: widget.sourceChat,
          chatModel: widget.chatmodels[index],
        ),
      ),
    );
  }
}
