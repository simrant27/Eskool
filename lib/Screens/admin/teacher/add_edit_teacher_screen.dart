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
    // _image.path =
    //     widget.teacher?.image.name!; // Set the initial value for enrolled
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

  void _removeFile(int index) {
    setState(() {
      _image = null;
    });
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

      // Call the createTeacher function
      try {
        await teacherService.createTeacher(
            teacher, _image); // Pass the image here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Teacher saved successfully!')),
        );
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.teacher == null ? 'Add Teacher' : 'Edit Teacher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(labelText: 'Full Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter full name' : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: _validateEmail,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter phone number' : null,
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter username' : null,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter password' : null,
                  obscureText: true,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) => value!.isEmpty ? 'Enter address' : null,
                ),
                TextFormField(
                  controller: _qualificationsController,
                  decoration: InputDecoration(
                      labelText: 'Qualifications (comma-separated)'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter qualifications' : null,
                ),
                TextFormField(
                  controller: _subjectsTaughtController,
                  decoration: InputDecoration(
                      labelText: 'Subjects Taught (comma-separated)'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter subjects taught' : null,
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
                CustomButton(
                  label: "Select files",
                  color: Colors.blue.shade100,
                  onPressed: _pickMediaFiles,
                ),
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
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: _saveTeacher,
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
