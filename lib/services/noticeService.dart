import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/notice_info_model.dart';

class NoticeService {
  final String baseUrl = 'http://192.168.18.121:3000/api/notices';

  Future<List<NoticeInfoModel>> fetchNotices() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((notice) => NoticeInfoModel.fromJson(notice))
          .toList();
    } else {
      throw Exception('Failed to load notices');
    }
  }
}
