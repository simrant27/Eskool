// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';
// import 'package:mime/mime.dart';

// class CreateTeacherPage extends StatefulWidget {
//   @override
//   _CreateTeacherPageState createState() => _CreateTeacherPageState();
// }

// class _CreateTeacherPageState extends State<CreateTeacherPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _subjectsTaughtController =
//       TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _qualificationsController =
//       TextEditingController();

//   File? _image; // Image file for upload
//   final picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       // Collect form data
//       var formData = {
//         "fullName": _fullNameController.text,
//         "email": _emailController.text,
//         "phone": _phoneController.text,
//         "subjectsTaught": _subjectsTaughtController.text.split(','),
//         "username": _usernameController.text,
//         "password": _passwordController.text,
//         "address": _addressController.text,
//         "qualifications": _qualificationsController.text.split(','),
//       };

//       await _createTeacher(formData);
//     }
//   }

//   Future<void> _createTeacher(Map<String, dynamic> teacherData) async {
//     var uri = Uri.parse('http://192.168.18.121:3000/api/teacher/create');
//     var request = http.MultipartRequest('POST', uri);

//     // Add the form fields
//     request.fields.addAll({
//       "fullName": teacherData['fullName'],
//       "email": teacherData['email'],
//       "phone": teacherData['phone'],
//       "subjectsTaught": teacherData['subjectsTaught'].join(','),
//       "username": teacherData['username'],
//       "password": teacherData['password'],
//       "address": teacherData['address'],
//       "qualifications": teacherData['qualifications'].join(','),
//     });

//     // Add the image file if selected
//     if (_image != null) {
//       var mimeTypeData = lookupMimeType(_image!.path)!.split('/');
//       var fileStream = http.ByteStream(_image!.openRead());
//       var fileLength = await _image!.length();

//       var multipartFile = http.MultipartFile(
//         'image', // field name in the backend
//         fileStream,
//         fileLength,
//         filename: basename(_image!.path),
//         contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
//       );
//       request.files.add(multipartFile);
//     }

//     try {
//       var response = await request.send();

//       if (response.statusCode == 201) {
//         print('Teacher created successfully');
//       } else {
//         print('Failed to create teacher');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Teacher'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _fullNameController,
//                 decoration: InputDecoration(labelText: 'Full Name'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter full name' : null,
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter email' : null,
//               ),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: 'Phone'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter phone number' : null,
//               ),
//               TextFormField(
//                 controller: _subjectsTaughtController,
//                 decoration: InputDecoration(
//                     labelText: 'Subjects Taught (comma separated)'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter subjects' : null,
//               ),
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(labelText: 'Username'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter username' : null,
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter password' : null,
//               ),
//               TextFormField(
//                 controller: _addressController,
//                 decoration: InputDecoration(labelText: 'Address'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter address' : null,
//               ),
//               TextFormField(
//                 controller: _qualificationsController,
//                 decoration: InputDecoration(
//                     labelText: 'Qualifications (comma separated)'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter qualifications' : null,
//               ),
//               SizedBox(height: 20),
//               _image == null
//                   ? Text('No image selected.')
//                   : Image.file(_image!, height: 100, width: 100),
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: Text('Pick Image'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 child: Text('Create Teacher'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
