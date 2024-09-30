import 'dart:convert';

import '../../constants/constants.dart';
import 'material_model.dart';
import 'package:http/http.dart' as http;

class MaterialService {
  final String apiUrl = '$url/api/materials'; // Make sure `$url` is correct

  Future<List<Materials>> fetchFiles() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((file) => Materials.fromJson(file)).toList();
    } else {
      throw Exception('Failed to load files');
    }
  }
}
