import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';
import 'package:eskool/Screens/admin/student/add_edit_student_form.dart';
import 'package:eskool/Screens/admin/student/student_detail_page.dart';
import 'package:eskool/Screens/admin/teacher/show_image.dart';
import 'package:eskool/models/ParentMode.dart';
import 'package:eskool/models/Students_model.dart';
import 'package:flutter/material.dart';
import '../../../services/studentService.dart';
import '../components/custon_button.dart';

class ParentDetailScreen extends StatefulWidget {
  final Parent parent;

  ParentDetailScreen({required this.parent});

  @override
  State<ParentDetailScreen> createState() => _ParentDetailScreenState();
}

class _ParentDetailScreenState extends State<ParentDetailScreen> {
  late Future<List<Student>> futureStudents;
  late StudentService studentService = StudentService();

  @override
  void initState() {
    super.initState();
    // Fetch students when the screen is initialized
    futureStudents = studentService.fetchStudentsByParentId(widget.parent.id!);
  }

  void _refreshStudents() {
    setState(() {
      futureStudents =
          studentService.fetchStudentsByParentId(widget.parent.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
      content: Scaffold(
        appBar: AppBar(
          title: Text(widget.parent.fullName ?? 'Parent Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 20),
                if (widget.parent.image != null) ...[
                  if (widget.parent.image!.endsWith('.jpg') ||
                      widget.parent.image!.endsWith('.png') ||
                      widget.parent.image!.endsWith('.jpeg')) ...[
                    Container(
                        width: MediaQuery.of(context).size.height / 2,
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 1, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.2),
                                blurRadius: 12,
                                spreadRadius: 8,
                              ),
                            ]),
                        child: showImage(widget.parent.image, "parent"))
                  ]
                ],
                VerticalDivider(
                  color: Colors.black12,
                  thickness: 1,
                  width: 20,
                  indent: 10,
                  endIndent: 10,
                ),
                // SizedBox(height: 16),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'Full Name: ${widget.parent.fullName ?? 'N/A'}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Email: ${widget.parent.email ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Phone: ${widget.parent.phone ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Username: ${widget.parent.username ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Address: ${widget.parent.address ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                ]),
              ]),
              Container(
                  width: MediaQuery.of(context).size.height / 1.9,
                  // margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Children",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        CustomButton(
                          label: "Create",
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEditStudentScreen(
                                  parentID: widget.parent.id!,
                                ),
                              ),
                            ).then((_) => _refreshStudents());
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      height: 1,
                    ),
                    Expanded(
                      child: FutureBuilder<List<Student>>(
                        future: futureStudents,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(child: Text('No Students found.'));
                          } else {
                            final students = snapshot.data!;
                            return ListView.builder(
                              itemCount: students.length,
                              itemBuilder: (context, index) {
                                final student = students[index];
                                return Container(
                                  // elevation: 4,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StudentDetailPage(
                                                        student: student)));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            student.fullName ?? 'No Name',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddEditStudentScreen(
                                                        parentID:
                                                            widget.parent.id!,
                                                        student: student,
                                                        onEditStudent:
                                                            (updatedStudent) {
                                                          _refreshStudents(); // Refresh the list after editing
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () async {
                                                  final confirm =
                                                      await showDialog<bool>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Confirm Deletion'),
                                                        content: Text(
                                                            'Are you sure you want to delete this Student?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false),
                                                            child:
                                                                Text('Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true),
                                                            child:
                                                                Text('Delete'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );

                                                  if (confirm == true) {
                                                    try {
                                                      await studentService
                                                          .deleteStudent(
                                                              student.id!);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                                'Student deleted successfully!')),
                                                      );
                                                      _refreshStudents(); // Refresh the student list
                                                    } catch (e) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                                'Error: $e')),
                                                      );
                                                    }
                                                  }
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
                    )
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
