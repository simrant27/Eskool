import 'package:eskool/Screens/admin/admindashboard/components/customAppbar.dart';
import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';
import 'package:eskool/Screens/admin/teacher/component/widget.dart';
import 'package:eskool/services/teacherService.dart';
import 'package:flutter/material.dart';
import '../../../models/teacherModel.dart';
import '../components/custon_button.dart';
import 'add_edit_teacher_screen.dart';
import 'teacher_detail_screen.dart';

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
    futureTeachers = teacherService.fetchTeachers();
  }

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

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Teacher",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CustomButton(
                  label: "Create",
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditTeacherScreen(
                          onAddTeacher: _addTeacher,
                        ),
                      ),
                    ).then((_) {
                      setState(() {
                        futureTeachers = teacherService.fetchTeachers();
                      });
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $error')),
                      );
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                          child: CustomListCard(
                            title: teacher.fullName ?? 'No Name',
                            subjectsTaught: teacher.subjectsTaught,
                            onEdit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddEditTeacherScreen(
                                    teacher: teacher,
                                    onEditTeacher: (updatedTeacher) {
                                      _editTeacher(updatedTeacher);
                                    },
                                  ),
                                ),
                              ).then((_) {
                                setState(() {
                                  futureTeachers =
                                      teacherService.fetchTeachers();
                                });
                              });
                            },
                            onDelete: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirm Deletion'),
                                    content: Text(
                                        'Are you sure you want to delete this teacher?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirm == true) {
                                try {
                                  await teacherService
                                      .deleteTeacher(teacher.id!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Teacher deleted successfully!')),
                                  );
                                  setState(() {
                                    futureTeachers =
                                        teacherService.fetchTeachers();
                                  });
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $e')),
                                  );
                                }
                              }
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
