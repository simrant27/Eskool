import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../models/ResultModel.dart';

class ResultService {
  static Future<List<Result>> fetchResultsByIds(List<String> ids) async {
    List<Result> results = [];
    for (String id in ids) {
      final response =
          await http.get(Uri.parse('https://yourapi.com/results/$id'));
      if (response.statusCode == 200) {
        results.add(Result.fromJson(jsonDecode(response.body)));
      } else {
        throw Exception('Failed to load result');
      }
    }
    return results;
  }
}
