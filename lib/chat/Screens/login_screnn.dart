import 'package:flutter/material.dart';

import '../CustomUi/button_card.dart';
import '../models/chat_model.dart';
import 'homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel? sourceChat; //object of chat model
  List<ChatModel> chatmodels = [
    ChatModel(
        name: "Asmita",
        icon: Icons.group,
        isGroup: false,
        time: "18.05",
        currentMessage: "hello there",
        id: 1),
    ChatModel(
        name: "Oshin",
        icon: Icons.group,
        isGroup: false,
        time: "18.05",
        currentMessage: "hello hii",
        id: 2),
    ChatModel(
        name: "class5",
        icon: Icons.group,
        isGroup: false,
        time: "18.05",
        currentMessage: "hello there",
        id: 3),
    ChatModel(
        name: "Suzu",
        icon: Icons.group,
        isGroup: false,
        time: "18.05",
        currentMessage: "hello there",
        id: 4),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chatmodels.length,
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  sourceChat = chatmodels.removeAt(index);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                chatmodels: chatmodels,
                                sourceChat: sourceChat!,
                              )));
                },
                child: ButtonCard(
                  name: chatmodels[index].name,
                  icon: Icons.person,
                ),
              )),
    );
  }
}