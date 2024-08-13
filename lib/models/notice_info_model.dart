import 'package:flutter/material.dart';

class NoticeInfoModel {
  final DateTime date;
  final String title;
  final String description;

  NoticeInfoModel(
      {required this.date, required this.title, required this.description});
}
