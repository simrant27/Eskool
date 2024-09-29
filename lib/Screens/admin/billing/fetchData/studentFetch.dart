import 'package:eskool/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/studentList.dart';

Future<List<Student>> fetchStudentsByClass(String className) async {
  try {
    print(
        "Fetching students for class: $className"); // Print before calling API

    final response = await http.get(
      Uri.parse('$url/api/student/$className'),
      headers: {'Content-Type': 'application/json'},
    );

    print(
        "API response status: ${response.statusCode}"); // Print the response status code

    if (response.statusCode == 200) {
      print("Response body: ${response.body}"); // Print the response body

      var jsonResponse = json.decode(response.body);
      print("Decoded JSON: $jsonResponse"); // Print decoded JSON response

      // Check if 'success' is true and 'students' exists
      if (jsonResponse['success'] == true && jsonResponse['students'] != null) {
        List studentsList = jsonResponse['students'];
        // Map the list to Student objects
        return studentsList.map((data) => Student.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load students data');
      }
    } else {
      print("Failed to load students: ${response.statusCode}");
      throw Exception('Failed to load students');
    }
  } catch (error) {
    print("Error occurred: $error"); // Print any error that occurs
    throw error; // Re-throw the error for higher-level handling
  }
}
