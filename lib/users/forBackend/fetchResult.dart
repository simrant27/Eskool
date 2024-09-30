import 'dart:convert';
import 'package:eskool/constants/constants.dart';
import 'package:http/http.dart' as http;

// Function to fetch results based on student ID
Future<List<dynamic>> fetchResult(String studentId) async {
  try {
    final response = await http.get(
      Uri.parse('$url/api/result/student-results/$studentId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> resultData = json.decode(response.body);

      // Check if resultData is a valid list
      if (resultData.isNotEmpty && resultData[0] is Map<String, dynamic>) {
        return resultData; // Successful response
      } else {
        throw Exception('Unexpected result format');
      }
    } else {
      throw Exception(
          'Failed to load result: Server returned status code ${response.statusCode}');
    }
  } catch (e) {
    // Handle network errors or parsing issues
    throw Exception('Error fetching result: $e');
  }
}
