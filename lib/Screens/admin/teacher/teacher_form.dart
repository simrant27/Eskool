// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../models/teacher_model.dart';
// import '../../../services/teacher_service.dart';

// class TeacherFormPopup extends StatefulWidget {
//   @override
//   _TeacherFormPopupState createState() => _TeacherFormPopupState();
// }

// class _TeacherFormPopupState extends State<TeacherFormPopup> {
//   final _formKey = GlobalKey<FormState>();
//   File? teacherPhoto;
//   final ImagePicker picker = ImagePicker();
//   bool isLoading = false;

//   // Teacher data fields
//   String? fullName,
//       email,
//       phone,
//       address,
//       subjects,
//       teacherID,
//       employmentDate,
//       qualification,
//       username,
//       password;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Teacher Account Form'),
//       content: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               buildFormField(
//                   'Full Name', Icons.person, (value) => fullName = value),
//               buildFormField(
//                   'Email Address', Icons.email, (value) => email = value,
//                   emailValidator: true),
//               buildFormField(
//                   'Phone Number', Icons.phone, (value) => phone = value,
//                   phoneValidator: true),
//               buildFormField('Address', Icons.home, (value) => address = value),
//               buildFormField(
//                   'Subjects Taught', Icons.book, (value) => subjects = value),
//               buildFormField(
//                   'Teacher ID', Icons.badge, (value) => teacherID = value),
//               buildFormField('Employment Date', Icons.calendar_today,
//                   (value) => employmentDate = value),
//               buildFormField('Qualification', Icons.school,
//                   (value) => qualification = value),
//               buildFormField('Username', Icons.person_outline,
//                   (value) => username = value),
//               buildFormField(
//                   'Password', Icons.lock, (value) => password = value,
//                   isPassword: true),

//               // Photo selection button
//               ElevatedButton.icon(
//                 icon: Icon(Icons.photo),
//                 label: Text('Add Photo'),
//                 onPressed: () async {
//                   final pickedFile =
//                       await picker.pickImage(source: ImageSource.gallery);
//                   if (pickedFile != null) {
//                     setState(() {
//                       teacherPhoto = File(pickedFile.path);
//                     });
//                   }
//                 },
//               ),
//               teacherPhoto != null
//                   ? Image.file(teacherPhoto!, height: 100, width: 100)
//                   : Container(),

//               // Submit button
//               ElevatedButton(
//                 onPressed: isLoading ? null : _submitTeacherForm,
//                 child: isLoading ? CircularProgressIndicator() : Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Build form fields with validation
//   TextFormField buildFormField(
//       String label, IconData icon, Function(String?) onSave,
//       {bool emailValidator = false,
//       bool phoneValidator = false,
//       bool isPassword = false}) {
//     return TextFormField(
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: Colors.deepPurple),
//         labelText: label,
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       obscureText: isPassword,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please enter $label';
//         }
//         if (emailValidator && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//           return 'Please enter a valid email';
//         }
//         if (phoneValidator && !RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
//           return 'Please enter a valid phone number';
//         }
//         return null;
//       },
//       onSaved: onSave,
//     );
//   }

//   // Submit teacher form
//   Future<void> _submitTeacherForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       setState(() => isLoading = true);

//       Teacher teacher = Teacher(
//         fullName: fullName!,
//         email: email!,
//         phone: phone!,
//         address: address!,
//         subjectsTaught: subjects!,
//         teacherID: teacherID!,
//         employmentDate: employmentDate!,
//         qualifications: qualification!,
//         username: username!,
//         password: password!,
//         imagePath: teacherPhoto?.path,
//       );

//       bool success =
//           await TeacherService().createTeacher(teacher, teacherPhoto);

//       setState(() => isLoading = false);

//       if (success) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Teacher created successfully!')));
//         Navigator.pop(context);
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('Failed to create teacher')));
//       }
//     }
//   }
// }
