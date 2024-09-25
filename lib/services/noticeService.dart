import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/notice_info_model.dart';
// Import your model

class NoticeService {
  final String apiUrl =
      'http://192.168.1.3:3000/api/notices'; // Replace with your API URL

  Future<List<NoticeInfoModel>> fetchNotices() async {
    final response = await http.get(Uri.parse(apiUrl)); // Make a GET request

    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => NoticeInfoModel.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load notices');
    }
  }
}
