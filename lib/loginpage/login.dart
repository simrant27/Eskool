import 'package:flutter/material.dart';
import 'dart:convert'; // For encoding and decoding JSON
import 'package:http/http.dart' as http;

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

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();

      try {
        // Define your API URL
        var url = Uri.parse(
            'http://192.168.18.56:3000/api/login'); // Change with your server IP and endpoint

        // Send login request
        var response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            'username': username,
            'password': password,
          }),
        );

        // Check the response
        if (response.statusCode == 200) {
          // Successfully logged in
          var data = json.decode(response.body);
          String token = data['token']; // Assuming your backend sends a token
          _showSuccessDialog(); // Navigate to the dashboard or show success message
        } else {
          setState(() {
            errorMessage = "Invalid username or password!";
          });
        }
      } catch (e) {
        setState(() {
          errorMessage = "An error occurred. Please try again.";
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _showSuccessDialog() {
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
                  context, '/parents'); // Redirect to dashboard
            },
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  void _showForgotPasswordDialog() {
    final _forgotPasswordFormKey = GlobalKey<FormState>();
    String _forgotEmail = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Forgot Password',
              style: TextStyle(color: Colors.teal[800])),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _forgotPasswordFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter your email to receive a password reset link.',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email, color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _forgotEmail = value!;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_forgotPasswordFormKey.currentState!.validate()) {
                        _forgotPasswordFormKey.currentState!.save();
                        // Implement your password reset logic here
                        print('Password reset link sent to: $_forgotEmail');
                        Navigator.of(context).pop(); // Close the dialog
                      }
                    },
                    child: Text('Send Reset Link'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
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
                                // onSaved: (value) {
                                //   _password = value!;
                                // },
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
                              TextButton(
                                onPressed: _showForgotPasswordDialog,
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Colors.teal.shade600,
                                    fontSize: 16,
                                  ),
                                ),
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
