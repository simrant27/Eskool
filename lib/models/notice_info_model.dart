import 'package:flutter/material.dart';

class NoticeInfoModel {
  final DateTime date;
  final String title;
  final String description;
  final List? files;

  NoticeInfoModel(
      {required this.date,
      required this.title,
      required this.description,
      this.files});
}
