import 'package:eskool/Screens/admin/admindashboard/components/customAppbar.dart';
import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';
import 'package:eskool/Screens/admin/components/custon_button.dart';
import 'package:flutter/material.dart';
import '../../../models/teacherModel.dart';
import 'add_edit_teacher_screen.dart';
import 'teacher_detail_screen.dart'; // Import the detail screen

class TeacherListScreen extends StatefulWidget {
  final List<Teacher> teachers;

  TeacherListScreen({required this.teachers});

  @override
  _TeacherListScreenState createState() => _TeacherListScreenState();
}

class _TeacherListScreenState extends State<TeacherListScreen> {
  // Method to add a new teacher to the list
  void _addTeacher(Teacher teacher) {
    setState(() {
      widget.teachers.add(teacher);
    });
  }

  void _editTeacher(Teacher updatedTeacher) {
    setState(() {
      final index = widget.teachers
          .indexWhere((t) => t.teacherID == updatedTeacher.teacherID);
      if (index != -1) {
        widget.teachers[index] = updatedTeacher;
      }
    });
  }

  void _deleteTeacher(String teacherID) {
    setState(() {
      widget.teachers.removeWhere((teacher) => teacher.teacherID == teacherID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
      content: Column(
        children: [
          CustomAppbar(
            showBackButton: true,
            showSearch: true,
            hinttext: "teacher",
          ),
          CustomButton(
            label: "Create",
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditTeacherScreen(
                    onAddTeacher:
                        _addTeacher, // Pass the callback to add a teacher
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.teachers.length,
              itemBuilder: (context, index) {
                final teacher = widget.teachers[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TeacherDetailScreen(teacher: teacher),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            teacher.fullName ?? 'No Name',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Email: ${teacher.email ?? 'No Email'}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Phone: ${teacher.phone ?? 'No Phone'}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Username: ${teacher.username}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddEditTeacherScreen(
                                        teacher: teacher,
                                        onEditTeacher: (updatedTeacher) {
                                          _editTeacher(
                                              updatedTeacher); // Call the edit method
                                        },
                                      ),
                                    ),
                                  ).then((_) {
                                    // Optionally, you can refresh the state if needed
                                    setState(() {});
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _deleteTeacher(teacher.teacherID!);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
