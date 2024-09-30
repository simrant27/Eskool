import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatModel {
  String name;
  IconData? icon;
  bool? isGroup;
  String? time;
  String? currentMessage;
  int? id;

  ChatModel(
      {required this.name,
      this.icon,
      this.isGroup,
      this.time,
      this.currentMessage,
      this.id});
}
