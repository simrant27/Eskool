import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eskool/models/notice_info_model.dart';

class NoticeService {
  // Define the backend URL
  static const String baseUrl = 'http://192.168.1.3:3000/api/notices';

  // Fetch notices from backend
  Future<List<NoticeInfoModel>> fetchNotices() async {
    final response = await http.get(Uri.parse('$baseUrl/notices'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> jsonResponse = json.decode(response.body);

      // Convert to a list of NoticeInfoModel
      return jsonResponse
          .map((notice) => NoticeInfoModel.fromJson(notice))
          .toList();
    } else {
      throw Exception('Failed to load notices');
    }
  }
}
