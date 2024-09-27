import 'package:eskool/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

class TeacherApiService {
  final String baseUrl = '$url/api/teacher'; // Update with your backend URL

  Future<void> createTeacher(Map<String, dynamic> teacherData) async {
    try {
      // Create the request
      var url = Uri.parse('$baseUrl/create'); // Update with your endpoint
      var request = http.MultipartRequest('POST', url);

      // Attach the fields to the request
      request.fields['fullName'] = teacherData['fullName'];
      request.fields['email'] = teacherData['email'];
      request.fields['phone'] = teacherData['phone'];
      request.fields['address'] = teacherData['address'];
      request.fields['subjectsTaught'] = teacherData['subjectsTaught'];
      request.fields['teacherID'] = teacherData['teacherID'];
      request.fields['employmentDate'] = teacherData['employmentDate'];
      request.fields['qualifications'] = teacherData['qualifications'];
      request.fields['username'] = teacherData['username'];
      request.fields['password'] = teacherData['password'];

      // Attach the image if available
      if (teacherData['image'] != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image',
          teacherData['image'],
          filename: 'teacher_image.jpg', // Change filename if needed
          // contentType: MediaType.parse(mimeType), // Use the MediaType
        ));
      }

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Teacher created successfully');
      } else {
        var responseBody = await response.stream.bytesToString();

        print(
            'Failed to create teacher: ${response.statusCode},Response: $responseBody');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
