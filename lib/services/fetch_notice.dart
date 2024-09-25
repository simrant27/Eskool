import 'dart:convert';

import 'package:eskool/constants/constants.dart';
import 'package:eskool/models/notice_info_model.dart';

import '../data/noticedata.dart';
import 'package:http/http.dart' as http;

Future<List<NoticeInfoModel>> fetchNotices() async {
  final response = await http.get(Uri.parse('$url/api/notices'));

  if (response.statusCode == 200) {
    // Parse the JSON response
    List<dynamic> jsonResponse = json.decode(response.body);
    List<NoticeInfoModel> notices =
        jsonResponse.map((notice) => NoticeInfoModel.fromJson(notice)).toList();

    // Update the global noticeData list
    noticeData.clear(); // Clear previous data if needed
    noticeData.addAll(notices); // Add fetched notices to the global list

    return notices; // Return the fetched notices
  } else {
    throw Exception('Failed to load notices');
  }
}
