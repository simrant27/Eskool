import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class LoginService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    var url1 = Uri.parse('$url/api/login');

    try {
      var response = await http.post(
        url1,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String token = data['token'];
        String redirect = data['redirect'];

        // Save login state and token in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('token', token);
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        await prefs.setString('role', decodedToken['role'] ?? 'No role found');

        // Return success and redirect path
        return {'success': true, 'redirect': redirect};
      } else {
        // Return failure with message from response body
        var errorData = json.decode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? "Invalid username or password!"
        };
      }
    } catch (e) {
      // Handle specific exceptions
      return {
        'success': false,
        'message': e is http.ClientException
            ? "Network error. Please check your connection."
            : "An error occurred: ${e.toString()}. Please try again."
      };
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // Remove login state
    await prefs.remove('token'); // Remove token
  }
}
