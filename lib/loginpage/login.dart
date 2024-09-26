import 'dart:ffi';

import 'package:eskool/services/loginService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding and decoding JSON
import 'package:http/http.dart' as http;
// import '../services/auth_service.dart'; // Import AuthService

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = "";

  final LoginService _authService = LoginService(); // Instance of AuthService
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();

      var result = await _authService.login(username, password);

      if (result['success']) {
        // Pass the redirect path to the success dialog
        _showSuccessDialog(result['redirect']);
      } else {
        setState(() {
          errorMessage = result['message'];
        });
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSuccessDialog(String redirectPath) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Login Successful"),
        content: Text("You have successfully logged in."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.pushReplacementNamed(
                  context, redirectPath); // Redirect to the correct dashboard
            },
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purpleAccent.shade100,
                  Colors.blueAccent.shade400
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  shadowColor: Colors.black54,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade700,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Login to continue',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 30),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  labelText: 'UserName',
                                  prefixIcon:
                                      Icon(Icons.email, color: Colors.teal),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white70,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon:
                                      Icon(Icons.lock, color: Colors.teal),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white70,
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30),
                              isLoading
                                  ? CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: _login,
                                      child: Text(
                                        'Login',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        shadowColor: Colors.black54,
                                        elevation: 8,
                                      ),
                                    ),
                              SizedBox(height: 15),
                              if (errorMessage.isNotEmpty)
                                Text(
                                  errorMessage,
                                  style: TextStyle(color: Colors.red),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
