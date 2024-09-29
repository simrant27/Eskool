import 'dart:convert';
import 'package:eskool/constants/constants.dart';
import 'package:http/http.dart' as http;

import '../Screens/admin/billing/data/studentList.dart';
import '../models/ResultModel.dart';
// import '../models/Students_model.dart';
// import '../models/Students_model.dart';

class StudentService {
  static const String baseUrl = '$url/api';

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

  static Future<List<Result>> fetchResultsByStudentId(String studentId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/result/student-results/$studentId'));
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((resultJson) => Result.fromJson(resultJson)).toList();
    } else {
      throw Exception('Failed to load results');
    }
  }
}
