import 'dart:convert';
import 'package:eskool/constants/constants.dart';
import 'package:http/http.dart' as http;

// Function to fetch fees based on student ID
Future<Map<String, dynamic>> fetchFees(String studentId) async {
  final response = await http
      .get(Uri.parse('$url/api/fees/student/$studentId'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    return json.decode(response.body);
  } else {
    // If the server did not return a 200 OK response, throw an exception
    throw Exception('Failed to load fees');
  }
}
