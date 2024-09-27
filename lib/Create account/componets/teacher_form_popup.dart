import 'dart:typed_data';
import 'package:eskool/Create%20account/services/teacher_api.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class TeacherFormPopup extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  TeacherFormPopup({required this.onSubmit});

  @override
  _TeacherFormPopupState createState() => _TeacherFormPopupState();
}

class _TeacherFormPopupState extends State<TeacherFormPopup> {
  final _formKey = GlobalKey<FormState>();
  String? fullName,
      email,
      phone,
      address,
      subjectsTaught,
      teacherID,
      employmentDate,
      qualifications,
      username,
      password;

  PlatformFile? _image;
  Uint8List? webImage;

  Future<void> _pickMediaFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg'],
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first;
        if (_image != null && _image!.bytes != null) {
          webImage = _image!.bytes; // Store bytes for web
        }
      });
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Teacher Account Form'),
      content: SingleChildScrollView(
        child: Container(
          width: 400,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildFormField(
                    'Full Name', Icons.person, (value) => fullName = value),
                SizedBox(height: 10),
                buildFormField(
                    'Email Address', Icons.email, (value) => email = value,
                    emailValidator: true),
                SizedBox(height: 10),
                buildFormField(
                    'Phone Number', Icons.phone, (value) => phone = value,
                    phoneValidator: true),
                SizedBox(height: 10),
                buildFormField(
                    'Address', Icons.home, (value) => address = value),
                SizedBox(height: 10),
                buildFormField('subjectsTaught Taught', Icons.book,
                    (value) => subjectsTaught = value),
                SizedBox(height: 10),
                buildFormField(
                    'Teacher ID', Icons.badge, (value) => teacherID = value),
                SizedBox(height: 10),
                buildFormField('Employment Date', Icons.calendar_today,
                    (value) => employmentDate = value),
                SizedBox(height: 10),
                buildFormField('qualifications', Icons.school,
                    (value) => qualifications = value),
                SizedBox(height: 10),
                buildFormField('Username', Icons.person_outline,
                    (value) => username = value),
                SizedBox(height: 10),
                buildFormField(
                    'Password', Icons.lock, (value) => password = value,
                    isPassword: true),
                SizedBox(height: 10),

                // Add image Button
                ElevatedButton.icon(
                  icon: isLoading
                      ? CircularProgressIndicator()
                      : Icon(Icons.image),
                  label: Text('Add image'),
                  onPressed: _pickMediaFiles,
                ),

                if (_image != null) ...[
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.image),
                    title: Text(_image?.name ??
                        'No Image Selected'), // Ensure null safety
                    trailing: IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _image = null;
                          webImage = null; // Remove the file
                        });
                      },
                    ),
                  ),
                ] else ...[
                  SizedBox(height: 10),
                  Text(
                      'No Image Selected'), // Show this if no image is selected
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // final TeacherApiService teacherApiService = TeacherApiService();
              // teacherApiService.createTeacher({
              //   'fullName': fullName,
              //   'email': email,
              //   'phone': phone,
              //   'address': address,
              //   'subjectsTaughtTaught': subjectsTaught,
              //   'teacherID': teacherID,

              //   'qualificationss': qualifications,
              //   'username': username,
              //   'password': password,
              //   'image': _image
              //       ?.bytes, // Send the image as bytes (null if not selected)
              // });
              widget.onSubmit({
                'fullName': fullName,
                'email': email,
                'phone': phone,
                'address': address,
                'subjectsTaughtTaught': subjectsTaught,
                'teacherID': teacherID,

                'qualificationss': qualifications,
                'username': username,
                'password': password,
                'image': _image
                    ?.bytes, // Send the image as bytes (null if not selected)
              });
              Navigator.of(context).pop();
            }
          },
          child: Text('Submit'),
        ),
      ],
    );
  }

  Widget buildFormField(String label, IconData icon, Function(String?) onSaved,
      {bool isPassword = false,
      bool emailValidator = false,
      bool phoneValidator = false}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
      obscureText: isPassword,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter $label';
      //   }
      //   if (emailValidator && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      //     return 'Please enter a valid email';
      //   }
      //   if (phoneValidator && !RegExp(r'^\d{10}$').hasMatch(value)) {
      //     return 'Please enter a valid 10-digit phone number';
      //   }
      //   return null;
      // },
      onSaved: onSaved,
    );
  }
}
