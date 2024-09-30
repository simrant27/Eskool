import 'dart:convert';
import 'package:eskool/constants/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../models/Students_model.dart';

class StudentService {
  final String baseUrl = "$url/api/student";

  // Fetch all students
  // Future<List<Student>> fetchStudents() async {
  //   final response = await http.get(Uri.parse('$baseUrl/'));

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = json.decode(response.body);
  //     if (data['students'] != null) {
  //       final List<dynamic> studentsJson = data['students'];
  //       return studentsJson.map((json) => Student.fromJson(json)).toList();
  //     } else {
  //       return [];
  //     }
  //   } else {
  //     throw Exception('Failed to load students');
  //   }
  // }

  // Fetch student by ID
  // Future<Student> fetchStudentById(String id) async {
  //   final response = await http.get(Uri.parse('$baseUrl/$id'));

  //   if (response.statusCode == 200) {
  //     return Student.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load student');
  //   }
  // }

  // Fetch students by class name
  Future<List<Student>> fetchStudentByClassName(String classAssigned) async {
    final response = await http.get(Uri.parse('$baseUrl/$classAssigned'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['students'] != null) {
        final List<dynamic> studentsJson = data['students'];
        return studentsJson.map((json) => Student.fromJson(json)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load students by parent clss name');
    }
  }

  // Fetch students by parent ID
  Future<List<Student>> fetchStudentsByParentId(String parentId) async {
    final response = await http.get(Uri.parse('$baseUrl/by-parent/$parentId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['students'] != null) {
        final List<dynamic> studentsJson = data['students'];
        return studentsJson.map((json) => Student.fromJson(json)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load students by parent ID');
    }
  }

  // Create a new student
  Future<void> createStudent(
      Map<String, dynamic> studentData, PlatformFile? image) async {
    var uri = Uri.parse("$baseUrl/create");
    var request = http.MultipartRequest('POST', uri);

    // Add the form fields
    request.fields.addAll({
      "fullName": studentData['fullName'],

      "classAssigned": studentData[
          'classAssigned'], // Assuming className is part of student data
      "studentId": studentData['studentId'],

      "address": studentData['address'],
      "gender": studentData['gender'],
      // Add parentID if applicable
      "parentID":
          studentData['parentID'], // Assuming you also want to include parentID
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
        print('Student created successfully');
      } else {
        print('Failed to create student');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Update student
  Future<void> updateStudent(String id, Student student) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(student.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update student');
    }
  }

  // Delete student
  Future<void> deleteStudent(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));

    if (response.statusCode != 200) {
      final body = json.decode(response.body);
      throw Exception(body['message'] ?? 'Failed to delete student');
    }
  }
}
