import 'dart:math';
import 'package:eskool/services/studentService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../models/Students_model.dart';
import '../components/custon_button.dart';

class AddEditStudentScreen extends StatefulWidget {
  final Student? student;
  final Function(Student)? onAddStudent;
  final Function(Student)? onEditStudent;
  final PlatformFile? image;
  final String parentID; // Parent ID passed from the parent detail page

  const AddEditStudentScreen({
    Key? key,
    this.student,
    this.onAddStudent,
    this.onEditStudent,
    this.image,
    required this.parentID, // Parent ID required
  }) : super(key: key);

  @override
  _AddEditStudentScreenState createState() => _AddEditStudentScreenState();
}

class _AddEditStudentScreenState extends State<AddEditStudentScreen> {
  final StudentService studentService = StudentService();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _classAssignedController;
  late TextEditingController _studentIdController;
  late TextEditingController _addressController;
  late TextEditingController _genderController;
  PlatformFile? _image;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.student?.fullName);
    _classAssignedController =
        TextEditingController(text: widget.student?.classAssigned);
    _studentIdController =
        TextEditingController(text: widget.student?.studentId);
    _addressController = TextEditingController(text: widget.student?.address);
    _genderController = TextEditingController(text: widget.student?.gender);

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
    _classAssignedController.dispose();
    _studentIdController.dispose();
    _addressController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  void _saveStudent() async {
    if (_formKey.currentState!.validate()) {
      Student student = Student(
        id: widget.student?.id,
        fullName: _fullNameController.text,
        classAssigned: _classAssignedController.text,
        studentId: _studentIdController.text,
        address: _addressController.text,
        gender: _genderController.text,
        parentID: widget.parentID, // Use the passed parentID
        // image: _image, // You may also add this if you are uploading an image
      );

      try {
        if (student.id == null) {
          // If no student ID exists, create a new student
          await studentService.createStudent(student.toJson(), _image);
          if (widget.onAddStudent != null) {
            widget.onAddStudent!(student);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Student added successfully!')),
          );
        } else {
          // If a student ID exists, update the existing student
          await studentService.updateStudent(student.id!, student);
          if (widget.onEditStudent != null) {
            widget.onEditStudent!(student);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Student updated successfully!')),
          );
        }
        Navigator.pop(context);
      } catch (e) {
        print("Student ID: ${student.id}");
        print("Parent ID: ${student.parentID}");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? 'Add Student' : 'Edit Student'),
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
                  controller: _classAssignedController,
                  decoration: InputDecoration(labelText: 'Class Assigned'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter class assigned' : null,
                ),
                TextFormField(
                  controller: _studentIdController,
                  decoration: InputDecoration(labelText: 'Student ID'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter student ID' : null,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) => value!.isEmpty ? 'Enter address' : null,
                ),
                TextFormField(
                  controller: _genderController,
                  decoration: InputDecoration(labelText: 'Gender'),
                  validator: (value) => value!.isEmpty ? 'Enter gender' : null,
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
                  onPressed: _saveStudent,
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
