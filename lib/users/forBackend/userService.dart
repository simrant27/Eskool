import 'dart:convert';
import 'package:eskool/constants/constants.dart';
import 'package:eskool/users/forBackend/fetchParent.dart';
import 'package:eskool/users/forBackend/fetchTeachersByid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'parent_model.dart';
import 'teacher_model.dart';

class UserService {
  Future fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get values from SharedPreferences and check for null
    String? token = prefs.getString('token');
    String? role = prefs.getString('role');
    String? userId = prefs.getString('userId');

    if (token == null || role == null || userId == null) {
      print('Token, role, or userId is null');
      return null; // Handle this case as necessary (e.g., navigate to login)
    }

    print('Fetched userId: $userId, role: $role, token: $token'); // Debugging

    try {
      // Fetch Parent or Teacher data based on role
      if (role == 'parent') {
        print("Fetching parent data for userId: $userId");
        print("haha ${fetchParents(userId)}");
        return fetchParents(userId);
      } else if (role == 'teacher') {
        print("Fetching teacher data for userId: $userId");
        return fetchTeachers(userId); // Deserialize Teacher data
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }

    return null; // Return null if role doesn't match expected values
  }
}
