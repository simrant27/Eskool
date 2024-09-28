import '../../Screens/admin/billing/data/studentList.dart';
import '../../constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Student>> fetchStudentsByParentId(String parentID) async {
  try {
    print("Fetching students for Parent: $parentID");

    final response = await http.get(
      Uri.parse('$url/api/student/parent/$parentID'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print("Decoded JSON: $jsonResponse");

      // Ensure it's a list before mapping
      if (jsonResponse is List) {
        return jsonResponse.map((data) => Student.fromJson(data)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      print("Failed to load students: ${response.statusCode}");
      throw Exception('Failed to load students');
    }
  } catch (error) {
    print("Error occurred: $error");
    throw error;
  }
}
