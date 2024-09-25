import 'dart:convert';
import 'dart:io';
import 'package:eskool/constants/constants.dart';
import 'package:http/http.dart' as http;
import '../models/teacher_model.dart';

class TeacherService {
  final String apiUrl = '$url/teachers/create';

  Future<bool> createTeacher(Teacher teacher, File? photo) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add teacher data
      teacher.toJson().forEach((key, value) {
        request.fields[key] = value;
      });

      // Add photo if available
      if (photo != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', photo.path));
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        return true; // Success
      } else {
        print('Failed to create teacher: ${response.statusCode}');
        return false; // Failure
      }
    } catch (e) {
      print('Error creating teacher: $e');
      return false;
    }
  }
}
