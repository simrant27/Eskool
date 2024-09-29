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

  Future<void> createTeacher(
      Map<String, dynamic> teacherData, PlatformFile? image) async {
    var uri = Uri.parse("$baseUrl/create");
    var request = http.MultipartRequest('POST', uri);

    // Add the form fields
    request.fields.addAll({
      "fullName": teacherData['fullName'],
      "email": teacherData['email'],
      "phone": teacherData['phone'],
      "subjectsTaught": teacherData['subjectsTaught'].join(','),
      "teacherID": teacherData['teacherID'],
      "username": teacherData['username'],
      "password": teacherData['password'],
      "address": teacherData['address'],
      "qualifications": teacherData['qualifications'].join(','),
    });

    // Add the image file if selected
    if (image != null) {
      String mimeType = '';
      if (image.extension == 'png') {
        mimeType = 'image/png';
      } else if (image.extension == 'jpg' || image.extension == 'jpeg') {
        mimeType = 'image/jpeg';
      }

      request.files.add(
        http.MultipartFile.fromBytes(
          'image', // 'file' should match the key used in your backend
          image.bytes!, // Use the bytes property for web
          filename: image.name,
          contentType: MediaType.parse(mimeType), // Use the MediaType
        ),
      );
    }

    try {
      var response = await request.send();

      if (response.statusCode == 201) {
        print('Teacher created successfully');
      } else {
        print('Failed to create teacher');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateTeacher(String id, Teacher teacher) async {
    print(id);
    // if (teacher.id == null) {
    //   throw Exception('Teacher ID cannot be null');
    // }
    final response = await http.put(
      Uri.parse('$baseUrl/update/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(teacher.toJson()),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update teacher');
    }
  }

  Future<void> deleteTeacher(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      // Extract message from response body for better error feedback
      final body = json.decode(response.body);
      throw Exception(body['message'] ?? 'Failed to delete teacher');
    }
  }
}
