import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> fetchLoggedInUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token != null && !JwtDecoder.isExpired(token)) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    // Now you can access user-specific data from the token
    String userId =
        decodedToken['_id']; // Example: Extract the user ID from the token
    String role = decodedToken['role']; // Extract the user's role
    
  }
}
