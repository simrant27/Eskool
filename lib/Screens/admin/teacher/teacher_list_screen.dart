import 'package:eskool/Screens/admin/admindashboard/components/customAppbar.dart';
import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';
import 'package:eskool/Screens/admin/components/custon_button.dart';
import 'package:eskool/Screens/admin/teacher/demo.dart';
import 'package:eskool/services/teacherService.dart';
import 'package:flutter/material.dart';
import '../../../models/teacherModel.dart';
import '../teacher1/add_edit_teacher_screen.dart';
import '../teacher1/teacher_detail_screen.dart';
import 'create_teacher_page.dart'; // Import the detail screen

class TeacherListScreen extends StatefulWidget {
  @override
  _TeacherListScreenState createState() => _TeacherListScreenState();
}

class _TeacherListScreenState extends State<TeacherListScreen> {
  late Future<List<Teacher>> futureTeachers;
  final TeacherService teacherService = TeacherService();

  @override
  void initState() {
    super.initState();
    // Fetch the list of teachers when the screen is initialized
    futureTeachers = teacherService.fetchTeachers();
  }

  // Method to add a new teacher to the list
  void _addTeacher(Teacher teacher) {
    setState(() {
      futureTeachers = teacherService.fetchTeachers();
    });
  }

  void _editTeacher(Teacher updatedTeacher) {
    setState(() {
      futureTeachers = teacherService.fetchTeachers();
    });
  }

  void _deleteTeacher(String teacherID) async {
    await teacherService
        .deleteTeacher(teacherID); // Call the delete method from the service
    setState(() {
      futureTeachers =
          teacherService.fetchTeachers(); // Refresh the list after deleting
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
            child: FutureBuilder<List<Teacher>>(
              future: futureTeachers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No teachers found.'));
                } else {
                  final teachers = snapshot.data!;
                  return ListView.builder(
                    itemCount: teachers.length,
                    itemBuilder: (context, index) {
                      final teacher = teachers[index];
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
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                                          setState(() {
                                            futureTeachers =
                                                teacherService.fetchTeachers();
                                          });
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
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
