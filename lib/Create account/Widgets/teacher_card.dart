import 'package:flutter/material.dart';

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
              Text('Name: ${teacher['fullName']}', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Email: ${teacher['email']}'),
              Text('Phone: ${teacher['phone']}'),
              Text('Subjects: ${teacher['subjects']}'),
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
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teacher photo and details inside a blue box layout
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (teacher['photoUrl'] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        teacher['photoUrl'],
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
                  Text('Subjects: ${teacher['subjects']}'),
                  Text('Address: ${teacher['address'] ?? 'N/A'}'),
                      Text('TeacherID: ${teacher['teacherID']}'),
                          Text('EmploymentDate: ${teacher['employmentDate']}'),
                              Text('Qualification: ${teacher['qualification']}'),
                                  Text('Username: ${teacher['username']}'),
                                      Text('Password: ${teacher['password']}'),

                ],
              ),
            ),
            SizedBox(height: 16),

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
                            onEdit(updatedTeacher); // Update with edited details
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
  late TextEditingController subjectsController;
  late TextEditingController addressController;
  late TextEditingController teacherIDController;
    late TextEditingController employmentDateController;
      late TextEditingController qualificationController;
        late TextEditingController usernameController;
          late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    // Initialize controllers with current teacher details
    fullNameController = TextEditingController(text: widget.teacher['fullName']);
    emailController = TextEditingController(text: widget.teacher['email']);
    phoneController = TextEditingController(text: widget.teacher['phone']);
    subjectsController = TextEditingController(text: widget.teacher['subjects']);
    addressController = TextEditingController(text: widget.teacher['address'] ?? '');
    teacherIDController = TextEditingController(text: widget.teacher['teacherID']);
    employmentDateController = TextEditingController(text: widget.teacher['employmentDate']);
    qualificationController = TextEditingController(text: widget.teacher['qualification']);
    usernameController = TextEditingController(text: widget.teacher['username']);
    passwordController = TextEditingController(text: widget.teacher['password']);
  }

  @override
  void dispose() {
    // Clean up controllers
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    subjectsController.dispose();
    addressController.dispose();
    teacherIDController.dispose();
    employmentDateController.dispose();
    qualificationController.dispose();
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
              controller: subjectsController,
              decoration: InputDecoration(labelText: 'Subjects'),
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
              controller: qualificationController,
              decoration: InputDecoration(labelText: 'qualification'),
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
              'subjects': subjectsController.text,
              'address': addressController.text,
              'teacherID': teacherIDController.text,
              'employmentDate': employmentDateController.text,
              'qualification': qualificationController.text,
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
