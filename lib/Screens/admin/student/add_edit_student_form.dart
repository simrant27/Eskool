import 'dart:math';
import 'package:eskool/Screens/admin/components/custom_page_layout.dart';
import 'package:eskool/services/studentService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../models/Students_model.dart';
import '../components/custon_button.dart';

enum Gender { male, female, other }

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
  Gender? _selectedGender; // To store selected gender
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

    // Initialize gender selection based on the student data
    if (widget.student?.gender == 'male') {
      _selectedGender = Gender.male;
    } else if (widget.student?.gender == 'female') {
      _selectedGender = Gender.female;
    } else {
      _selectedGender = Gender.other;
    }

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
        gender: _selectedGender == Gender.male
            ? 'male'
            : _selectedGender == Gender.female
                ? 'female'
                : 'other', // Save the gender as string
        parentID: widget.parentID, // Use the passed parentID
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter full name' : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _classAssignedController,
                        decoration: InputDecoration(
                          labelText: 'Class Assigned',
                          prefixIcon: Icon(Icons.class_),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter class assigned' : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _studentIdController,
                        decoration: InputDecoration(
                          labelText: 'Student ID',
                          prefixIcon: Icon(Icons.badge),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter student ID' : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          prefixIcon: Icon(Icons.home),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter address' : null,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Gender',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Radio<Gender>(
                            value: Gender.male,
                            groupValue: _selectedGender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                          Text('Male'),
                          Radio<Gender>(
                            value: Gender.female,
                            groupValue: _selectedGender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                          Text('Female'),
                          Radio<Gender>(
                            value: Gender.other,
                            groupValue: _selectedGender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                          Text('Other'),
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
                                _image = null;
                              });
                            },
                          ),
                        ),
                      ],
                      SizedBox(height: 10),
                      CustomButton(
                          label: "Submit",
                          color: Colors.green.withOpacity(0.2),
                          onPressed: _saveStudent),
                      SizedBox(height: 10),
                      CustomButton(
                          label: "Cancel",
                          color: Colors.red.shade200,
                          onPressed: () => Navigator.pop(context))
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
