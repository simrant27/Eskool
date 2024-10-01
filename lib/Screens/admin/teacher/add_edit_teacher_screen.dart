import 'dart:math';

import 'package:eskool/Screens/admin/components/custom_page_layout.dart';
import 'package:eskool/services/teacherService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../models/teacherModel.dart';
import 'package:file_picker/file_picker.dart';

import '../components/custon_button.dart';

class AddEditTeacherScreen extends StatefulWidget {
  final Teacher? teacher;
  final Function(Teacher)? onAddTeacher;
  final Function(Teacher)? onEditTeacher;
  final PlatformFile? image;
  const AddEditTeacherScreen({
    Key? key,
    this.teacher,
    this.onAddTeacher,
    this.onEditTeacher,
    this.image,
  }) : super(key: key);

  @override
  _AddEditTeacherScreenState createState() => _AddEditTeacherScreenState();
}

class _AddEditTeacherScreenState extends State<AddEditTeacherScreen> {
  final TeacherService teacherService = TeacherService();

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _addressController;
  late TextEditingController _qualificationsController;
  late TextEditingController _subjectsTaughtController;
  bool _isEnrolled = false;
  PlatformFile? _image;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.teacher?.fullName);
    _emailController = TextEditingController(text: widget.teacher?.email);
    _phoneController = TextEditingController(text: widget.teacher?.phone);
    _usernameController = TextEditingController(text: widget.teacher?.username);
    _passwordController = TextEditingController(text: widget.teacher?.password);
    _addressController = TextEditingController(text: widget.teacher?.address);
    _qualificationsController =
        TextEditingController(text: widget.teacher?.qualifications?.join(', '));
    _subjectsTaughtController =
        TextEditingController(text: widget.teacher?.subjectsTaught?.join(', '));
    _isEnrolled = widget.teacher?.enrolled ?? false;
    _image = widget.image;
  }

  Future<void> _pickMediaFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg'],
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first;
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _qualificationsController.dispose();
    _subjectsTaughtController.dispose();
    super.dispose();
  }

  void _saveTeacher() async {
    if (_formKey.currentState!.validate()) {
      Teacher teacher = Teacher(
        id: widget.teacher?.id,
        fullName: _fullNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        subjectsTaught: _subjectsTaughtController.text
            .split(',')
            .map((subject) => subject.trim())
            .toList(),
        address: _addressController.text,
        qualifications: _qualificationsController.text
            .split(',')
            .map((qualification) => qualification.trim())
            .toList(),
        enrolled: _isEnrolled,
        username: _usernameController.text,
        password: _passwordController.text,
        teacherID: widget.teacher?.teacherID ?? UniqueKey().toString(),
        // image: _image,
      );

      try {
        if (teacher.id == null) {
          // If no teacher ID exists, create a new teacher
          await teacherService.createTeacher(teacher.toJson(), _image);
          if (widget.onAddTeacher != null) {
            widget.onAddTeacher!(teacher);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Teacher added successfully!')),
          );
        } else {
          // If a teacher ID exists, update the existing teacher
          await teacherService.updateTeacher(teacher.id!, teacher);
          if (widget.onEditTeacher != null) {
            widget.onEditTeacher!(teacher);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Teacher updated successfully!')),
          );
        }
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  String? _validateEmail(String? value) {
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value == null || value.isEmpty) {
      return 'Enter email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
      child: Center(
        // Center the form
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            elevation: 6.0, // Add elevation for shadow effect
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            child: Container(
              width:
                  MediaQuery.of(context).size.width * 0.85, // Limit form width
              padding: const EdgeInsets.all(16.0), // Padding inside the Card
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person), // Add icon
                          border: OutlineInputBorder(),
                        ),
                        // validator: (value) =>
                        //     value!.isEmpty ? 'Enter full name' : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email), // Add icon
                          border: OutlineInputBorder(),
                        ),
                        // validator: _validateEmail,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          prefixIcon: Icon(Icons.phone), // Add icon
                          border: OutlineInputBorder(),
                        ),
                        // validator: (value) =>
                        //     value!.isEmpty ? 'Enter phone number' : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.account_circle), // Add icon
                          border: OutlineInputBorder(),
                        ),
                        // validator: (value) =>
                        //     value!.isEmpty ? 'Enter username' : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock), // Add icon
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        // validator: (value) =>
                        //     value!.isEmpty ? 'Enter password' : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          prefixIcon: Icon(Icons.home), // Add icon
                          border: OutlineInputBorder(),
                        ),
                        // validator: (value) =>
                        //     value!.isEmpty ? 'Enter address' : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _qualificationsController,
                        decoration: InputDecoration(
                          labelText: 'Qualifications (comma-separated)',
                          prefixIcon: Icon(Icons.school), // Add icon
                          border: OutlineInputBorder(),
                        ),
                        // validator: (value) =>
                        //     value!.isEmpty ? 'Enter qualifications' : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _subjectsTaughtController,
                        decoration: InputDecoration(
                          labelText: 'Subjects Taught (comma-separated)',
                          prefixIcon: Icon(Icons.book), // Add icon
                          border: OutlineInputBorder(),
                        ),
                        // validator: (value) =>
                        //     value!.isEmpty ? 'Enter subjects taught' : null,
                      ),
                      SizedBox(height: 10),
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
                      CustomButton(
                        label: "Select files",
                        color: Colors.blue.shade100,
                        onPressed: _pickMediaFiles,
                      ),
                      if (_image != null) ...[
                        SizedBox(height: 10),
                        ListTile(
                          leading: Icon(
                            _image!.extension == 'pdf'
                                ? Icons.picture_as_pdf
                                : Icons.image,
                          ),
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
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: _saveTeacher,
                        icon: Icon(Icons.save), // Add save icon
                        label: Text('Save'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
