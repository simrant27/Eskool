import 'dart:convert';
import 'package:eskool/constants/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../models/teacherModel.dart';
import 'dart:convert';
import 'dart:io';

class TeacherService {
  final String baseUrl = "$url/api/teacher";

  Future<List<Teacher>> fetchTeachers() async {
    final response = await http.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      // Check if 'teachers' exists in the response
      if (data['teachers'] != null) {
        final List<dynamic> teachersJson = data['teachers'];
        return teachersJson.map((json) => Teacher.fromJson(json)).toList();
      } else {
        return []; // Return an empty list if no teachers are found
      }
    } else {
      throw Exception('Failed to load teachers');
    }
  }

  Future<Teacher> fetchTeacherById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Teacher.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load teacher');
    }
  }

  Future<void> createTeacher(Teacher teacher, PlatformFile? image) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/create'));

    request.fields['teacher'] = json.encode(teacher.toJson());

    // Add image if available
    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromBytes(
          'image',
          image.bytes!,
          filename: image.name,
          contentType: MediaType(
              'image', 'jpg'), // Adjust MIME type based on the file type
        ),
      );
    }

    // Send request
    final response = await request.send();

    // Capture the response body
    final responseBody = await response.stream.bytesToString();

    print('Response status: ${response.statusCode}');
    print('Response body: $responseBody');

    if (response.statusCode != 201) {
      throw Exception('Failed to create teacher: $responseBody');
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
