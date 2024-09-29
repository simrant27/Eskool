import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:path/path.dart';
import 'package:mime/mime.dart';

class ApiService {
  final String apiUrl = 'http://192.168.18.121:3000/api/teacher/create';

  Future<void> createTeacher(
      Map<String, dynamic> teacherData, PlatformFile? image) async {
    var uri = Uri.parse(apiUrl);
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
}
