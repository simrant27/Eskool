import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import 'teacher_model.dart';

Future<Teacher?> fetchTeachers(String id) async {
  try {
    print("Fetching  Teacher: $id");
    final response = await http.get(
      Uri.parse('$url/api/teacher/find/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      print(decodeData);
      return Teacher.fromJson(decodeData["teacher"]);
    } else {
      throw Exception('Failed to load teacher data');
    }
  } catch (error) {
    print("Error occurred: $error"); // Print any error that occurs
    throw error; // Re-throw the error for higher-level handling
  }
}
