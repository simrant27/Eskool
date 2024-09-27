import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
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
      subjects,
      teacherID,
      employmentDate,
      qualification,
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
                buildFormField(
                    'Subjects Taught', Icons.book, (value) => subjects = value),
                SizedBox(height: 10),
                buildFormField(
                    'Teacher ID', Icons.badge, (value) => teacherID = value),
                SizedBox(height: 10),
                buildFormField('Employment Date', Icons.calendar_today,
                    (value) => employmentDate = value),
                SizedBox(height: 10),
                buildFormField('Qualification', Icons.school,
                    (value) => qualification = value),
                SizedBox(height: 10),
                buildFormField('Username', Icons.person_outline,
                    (value) => username = value),
                SizedBox(height: 10),
                buildFormField(
                    'Password', Icons.lock, (value) => password = value,
                    isPassword: true),
                SizedBox(height: 10),
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onSubmit({
                'fullName': fullName,
                'email': email,
                'phone': phone,
                'address': address,
                'subjects': subjects,
                'teacherID': teacherID,
                'employmentDate': employmentDate,
                'qualification': qualification,
                'username': username,
                'password': password,
                'image': _image?.bytes,
              });
              Navigator.pop(context);
            }
          },
          child: Text('Submit'),
        ),
      ],
    );
  }

  TextFormField buildFormField(
      String label, IconData icon, Function(String?) onSave,
      {bool emailValidator = false,
      bool phoneValidator = false,
      bool isPassword = false}) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        labelText: label,
        labelStyle: TextStyle(color: Colors.deepPurple),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      obscureText: isPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $label';
        }
        if (emailValidator && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        if (phoneValidator && !RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
      onSaved: onSave,
    );
  }
}
