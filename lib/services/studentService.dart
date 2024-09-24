import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Students_model.dart';

class StudentService {
  static const String baseUrl = 'http://192.168.18.56:3000/api';

  static Future<List<Student>> fetchStudentsByClass(String className) async {
    final response =
        await http.get(Uri.parse('$baseUrl/student/class?class=$className'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((studentJson) => Student.fromJson(studentJson)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }
}
