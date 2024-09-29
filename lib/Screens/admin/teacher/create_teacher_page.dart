import 'dart:io';
import 'package:eskool/services/teacherService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/teacherModel.dart';

import 'teacher_service.dart';

class CreateTeacherForm extends StatefulWidget {
  @override
  _CreateTeacherFormState createState() => _CreateTeacherFormState();
}

class _CreateTeacherFormState extends State<CreateTeacherForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _subjectsTaughtController =
      TextEditingController();
  final TextEditingController _teacherID = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _qualificationsController =
      TextEditingController();
  bool _isEnrolled = false;

  PlatformFile? _image; // Image file for upload
  // final picker = ImagePicker();
  final TeacherService teacherService = TeacherService();

  Future<void> _pickMediaFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a Teacher object
      var teacher = Teacher(
        fullName: _fullNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        subjectsTaught: _subjectsTaughtController.text.split(','),
        teacherID: _teacherID.text,
        username: _usernameController.text,
        password: _passwordController.text,
        address: _addressController.text,
        qualifications: _qualificationsController.text.split(','),
      );
      // File? fileToUpload;
      // if (_image != null) {
      //   fileToUpload = File(_image!.path!);
      // }

      await teacherService.createTeacher(teacher.toJson(), _image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Teacher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter full name' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter email' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter phone number' : null,
              ),
              TextFormField(
                controller: _subjectsTaughtController,
                decoration: InputDecoration(
                    labelText: 'Subjects Taught (comma separated)'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter subjects' : null,
              ),
              TextFormField(
                controller: _teacherID,
                decoration: InputDecoration(labelText: 'TeacherID'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter username' : null,
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter username' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter password' : null,
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter address' : null,
              ),
              TextFormField(
                controller: _qualificationsController,
                decoration: InputDecoration(
                    labelText: 'Qualifications (comma separated)'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter qualifications' : null,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isEnrolled,
                    onChanged: (value) {
                      setState(() {
                        _isEnrolled = value ?? false;
                      });
                    },
                  ),
                  Text('Enrolled'),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              if (_image != null) ...[
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(_image!.extension == 'pdf'
                      ? Icons.picture_as_pdf
                      : Icons.image),
                  title: Text(_image!.name),
                  trailing: IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _image = null; // Remove the file
                      });
                    },
                  ),
                ),
              ],
              ElevatedButton(
                onPressed: _pickMediaFiles,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Create Teacher'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
