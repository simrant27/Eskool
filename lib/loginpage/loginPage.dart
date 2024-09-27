// import 'package:flutter/material.dart';
// import 'dart:convert'; // For encoding and decoding JSON
// import 'package:http/http.dart' as http; // For making HTTP requests

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool isLoading = false;
//   String errorMessage = "";

//   // Function to handle login
//   Future<void> _login() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         isLoading = true;
//       });

//       String username = _usernameController.text.trim();
//       String password = _passwordController.text.trim();

//       try {
//         // Define your API URL
//         var url = Uri.parse(
//             'http://192.168.18.56:3000/api/login'); // Change with your server IP and endpoint

//         // Send login request
//         var response = await http.post(
//           url,
//           headers: {"Content-Type": "application/json"},
//           body: json.encode({
//             'username': username,
//             'password': password,
//           }),
//         );

//         // Check the response
//         if (response.statusCode == 200) {
//           // Successfully logged in
//           var data = json.decode(response.body);
//           String token = data['token']; // Assuming your backend sends a token
//           _showSuccessDialog(); // Navigate to the dashboard or show success message
//         } else {
//           setState(() {
//             errorMessage = "Invalid username or password!";
//           });
//         }
//       } catch (e) {
//         setState(() {
//           errorMessage = "An error occurred. Please try again.";
//         });
//       } finally {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }

//   // Function to display success message after login
//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Login Successful"),
//         content: Text("You have successfully logged in."),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close dialog
//               Navigator.pushReplacementNamed(
//                   context, '/parents'); // Redirect to dashboard
//             },
//             child: Text("OK"),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Parent Login"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(
//                   labelText: "Username",
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.person),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your username';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   labelText: "Password",
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.lock),
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               isLoading
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                       onPressed: _login,
//                       child: Text("Login"),
//                     ),
//               SizedBox(height: 20),
//               if (errorMessage.isNotEmpty)
//                 Text(
//                   errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
