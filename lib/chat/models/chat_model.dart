import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatModel {
  String name;
  IconData? icon;

  String? time;
  String? currentMessage;
  String? id;

  ChatModel(
      {required this.name, this.icon, this.time, this.currentMessage, this.id});
}
