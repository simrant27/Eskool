import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  // Simulate login process
  Future<bool> login(String username, String password) async {
    // Perform login logic here (e.g., API call)
    // If login is successful, store the user state

    // Simulated success response
    bool loginSuccess =
        (username == 'admin' && password == 'password'); // Just an example

    if (loginSuccess) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true); // Save login state
      await prefs.setString(
          'username', username); // Optionally save username or token
    }

    return loginSuccess;
  }

  // To check if the user is already logged in
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false; // Check login state
  }

  // Logout function
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all saved preferences (including login state)
  }
}
