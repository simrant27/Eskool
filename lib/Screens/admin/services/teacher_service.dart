// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../../../constants/constants.dart';
// import '../../../models//teacher.dart';
// // import '../utils/api.dart';

// class TeacherService {
//   static const String _baseUrl = "$url/teacher";

//   // Fetch all teachers
//   static Future<List<Teacher>> fetchTeachers() async {
//     final response = await http.get(Uri.parse(_baseUrl));
//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       return data.map((json) => Teacher.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load teachers');
//     }
//   }

//   // Create teacher
//   static Future<void> createTeacher(Teacher teacher) async {
//     final response = await http.post(
//       Uri.parse(_baseUrl),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(teacher.toJson()),
//     );
//     if (response.statusCode != 201) {
//       throw Exception('Failed to create teacher');
//     }
//   }

//   // Update teacher
//   static Future<void> updateTeacher(String id, Teacher teacher) async {
//     final response = await http.put(
//       Uri.parse('$_baseUrl/$id'),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(teacher.toJson()),
//     );
//     if (response.statusCode != 200) {
//       throw Exception('Failed to update teacher');
//     }
//   }

//   // Delete teacher
//   static Future<void> deleteTeacher(String id) async {
//     final response = await http.delete(Uri.parse('$_baseUrl/$id'));
//     if (response.statusCode != 200) {
//       throw Exception('Failed to delete teacher');
//     }
//   }
// }
