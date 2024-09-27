import 'dart:convert';
import 'package:eskool/constants/constants.dart';
import 'package:http/http.dart' as http;
import '../models/teacherModel.dart';
import 'dart:convert';

class TeacherService {
  final String baseUrl = "$url/api/teacher";

  Future<List<Teacher>> fetchTeachers() async {
    final response = await http.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((teacher) => Teacher.fromJson(teacher)).toList();
    } else {
      throw Exception('Failed to load teachers');
    }
  }

  Future<Teacher> fetchTeacherById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/teachers/$id'));

    if (response.statusCode == 200) {
      return Teacher.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load teacher');
    }
  }

  Future<void> createTeacher(Teacher teacher) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/teachers'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(teacher.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create teacher');
    }
  }

  Future<void> updateTeacher(String id, Teacher teacher) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/teachers/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(teacher.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update teacher');
    }
  }

  Future<void> deleteTeacher(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/api/teachers/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete teacher');
    }
  }
}
