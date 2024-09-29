import 'package:eskool/Screens/admin/admindashboard/components/customAppbar.dart';
import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../models/Students_model.dart';
import '../../../services/studentService.dart';

import 'fullStudentDetail.dart';

import 'package:http/http.dart' as http;

class StudentDetail extends StatefulWidget {
  final String className;

  const StudentDetail({super.key, required this.className});

  @override
  _StudentDetailState createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  String searchQuery = "";
  List<Student> students = [];
  List<Student> filteredStudents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  void fetchStudents() async {
    try {
      final fetchedStudents =
          await StudentService.fetchStudentsByClass(widget.className);

      // Sort students alphabetically by fullName
      fetchedStudents.sort((a, b) => a.fullName.compareTo(b.fullName));

      setState(() {
        students = fetchedStudents;

        // Assign roll numbers serially
        for (int i = 0; i < students.length; i++) {
          students[i].rollNumber =
              (i + 1).toString(); // Set roll number as 1, 2, 3, etc.
        }

        filteredStudents = students;
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredStudents = students
          .where((student) =>
              student.fullName.toLowerCase().contains(query.toLowerCase()) ||
              student.studentId.contains(query))
          .toList();
    });
  }

  void navigateToDetail(Student student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullStudentDetail(student: student),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double columnSpacing = MediaQuery.of(context).size.width * 0.2;

    return ResponsiveDrawerLayout(
      content: Column(
        children: [
          CustomAppbar(
            hinttext: "Search Students",
            showSearch: true,
            onChanged: updateSearch,
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the table
                    border: Border.all(
                      color: Colors.transparent, // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.1), // Shadow color with opacity
                        spreadRadius: 2, // How much the shadow spreads
                        blurRadius: 10, // The blur intensity
                        offset:
                            Offset(4, 4), // The position of the shadow (x, y)
                      ),
                    ],
                  ),
                  child: DataTable(
                    columnSpacing: columnSpacing,
                    columns: const [
                      DataColumn(
                          label: Text('Roll No',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Name',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Grade',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Parent Name',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: filteredStudents
                        .map(
                          (student) => DataRow(
                            cells: [
                              DataCell(
                                Text(student.rollNumber!),
                                onTap: () => navigateToDetail(student),
                              ),
                              DataCell(
                                Text(student.fullName),
                                onTap: () => navigateToDetail(student),
                              ),
                              DataCell(
                                Text(student.classAssigned),
                                onTap: () => navigateToDetail(student),
                              ),
                              DataCell(
                                Text(student.parentName),
                                onTap: () => navigateToDetail(student),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
