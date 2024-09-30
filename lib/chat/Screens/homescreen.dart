import 'package:flutter/material.dart';

import '../Pages/chat_page.dart';
import '../models/chat_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.chatmodels, required this.sourceChat});
  final List<ChatModel> chatmodels;
  final ChatModel sourceChat;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade200,
          title: Text(
            "Chats",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ],
        ),
        body: ChatPage(
          chatmodels: widget.chatmodels,
          sourceChat: widget.sourceChat,
        ));
  }
}