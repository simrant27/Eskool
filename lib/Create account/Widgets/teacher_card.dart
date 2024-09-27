import 'package:eskool/constants/constants.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class TeacherCard extends StatelessWidget {
  final Map<String, dynamic> teacher;
  final Function(Map<String, dynamic>) onEdit;
  final Function() onDelete;

  TeacherCard({
    required this.teacher,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show dialog with teacher details and options to edit and delete
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: TeacherDetailPopup(
                teacher: teacher,
                onEdit: onEdit,
                onDelete: onDelete,
              ),
            );
          },
        );
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${teacher['fullName']}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Email: ${teacher['email']}'),
              Text('Phone: ${teacher['phone']}'),
              Text('subjectsTaught: ${teacher['subjectsTaught']}'),
            ],
          ),
        ),
      ),
    );
  }
}

class TeacherDetailPopup extends StatelessWidget {
  final Map<String, dynamic> teacher;
  final Function(Map<String, dynamic>) onEdit;
  final Function() onDelete;

  TeacherDetailPopup({
    required this.teacher,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes = teacher['image'];

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teacher image and details inside a blue box layout
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (teacher['image'] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        teacher['image'],
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  SizedBox(height: 10),
                  Text(
                    'Teacher Name: ${teacher['fullName']}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('Email: ${teacher['email']}'),
                  Text('Phone: ${teacher['phone']}'),
                  Text('subjectsTaught: ${teacher['subjectsTaught']}'),
                  Text('Address: ${teacher['address'] ?? 'N/A'}'),
                  Text('TeacherID: ${teacher['teacherID']}'),
                  Text('EmploymentDate: ${teacher['employmentDate']}'),
                  Text('qualifications: ${teacher['qualifications']}'),
                  Text('Username: ${teacher['username']}'),
                  Text('Password: ${teacher['password']}'),
                ],
              ),
            ),
            SizedBox(height: 16),
            if (imageBytes != null)
              Column(
                children: [
                  Text('image:'),
                  SizedBox(height: 10),
                  Image.memory(imageBytes), // Display the uploaded image
                ],
              ),

            // Buttons for editing and deleting
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the popup
                    showDialog(
                      context: context,
                      builder: (context) {
                        return TeacherEditForm(
                          teacher: teacher,
                          onSave: (updatedTeacher) {
                            onEdit(
                                updatedTeacher); // Update with edited details
                          },
                        );
                      },
                    );
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the popup
                    onDelete(); // Call delete function
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Close button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// The Edit Form widget
class TeacherEditForm extends StatefulWidget {
  final Map<String, dynamic> teacher;
  final Function(Map<String, dynamic>) onSave;

  TeacherEditForm({
    required this.teacher,
    required this.onSave,
  });

  @override
  _TeacherEditFormState createState() => _TeacherEditFormState();
}

class _TeacherEditFormState extends State<TeacherEditForm> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController subjectsTaughtController;
  late TextEditingController addressController;
  late TextEditingController teacherIDController;
  late TextEditingController employmentDateController;
  late TextEditingController qualificationsController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    // Initialize controllers with current teacher details
    fullNameController =
        TextEditingController(text: widget.teacher['fullName']);
    emailController = TextEditingController(text: widget.teacher['email']);
    phoneController = TextEditingController(text: widget.teacher['phone']);
    subjectsTaughtController =
        TextEditingController(text: widget.teacher['subjectsTaught']);
    addressController =
        TextEditingController(text: widget.teacher['address'] ?? '');
    teacherIDController =
        TextEditingController(text: widget.teacher['teacherID']);
    employmentDateController =
        TextEditingController(text: widget.teacher['employmentDate']);
    qualificationsController =
        TextEditingController(text: widget.teacher['qualifications']);
    usernameController =
        TextEditingController(text: widget.teacher['username']);
    passwordController =
        TextEditingController(text: widget.teacher['password']);
  }

  @override
  void dispose() {
    // Clean up controllers
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    subjectsTaughtController.dispose();
    addressController.dispose();
    teacherIDController.dispose();
    employmentDateController.dispose();
    qualificationsController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Teacher Details'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: subjectsTaughtController,
              decoration: InputDecoration(labelText: 'subjectsTaught'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: teacherIDController,
              decoration: InputDecoration(labelText: 'TeacherID'),
            ),
            TextField(
              controller: employmentDateController,
              decoration: InputDecoration(labelText: 'employmentDate'),
            ),
            TextField(
              controller: qualificationsController,
              decoration: InputDecoration(labelText: 'qualifications'),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'password'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Save updated teacher data
            Map<String, dynamic> updatedTeacher = {
              'fullName': fullNameController.text,
              'email': emailController.text,
              'phone': phoneController.text,
              'subjectsTaught': subjectsTaughtController.text,
              'address': addressController.text,
              'teacherID': teacherIDController.text,
              'employmentDate': employmentDateController.text,
              'qualifications': qualificationsController.text,
              'username': usernameController.text,
              'password': passwordController.text,
            };

            widget.onSave(updatedTeacher); // Call the save function
            Navigator.pop(context); // Close the form
          },
          child: Text('Save'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Close without saving
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
