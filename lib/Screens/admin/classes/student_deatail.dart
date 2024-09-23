import 'package:eskool/Screens/admin/admindashboard/components/customAppbar.dart';
import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';
import 'package:eskool/Screens/admin/classes/fullStudentDetail.dart';
import 'package:eskool/data/student_data.dart';
import 'package:eskool/models/Students_model.dart';

import 'package:flutter/material.dart';

class StudentDetail extends StatefulWidget {
  final String className;

  const StudentDetail({super.key, required this.className});

  @override
  _StudentDetailState createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  String searchQuery = "";
  List<Student> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    // Initialize the filteredStudents with the students from the selected class
    filteredStudents = classWiseStudents[widget.className] ?? [];
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredStudents = classWiseStudents[widget.className]
              ?.where((student) =>
                  student.name.toLowerCase().contains(query.toLowerCase()) ||
                  student.rollNo.contains(query))
              .toList() ??
          [];
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
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: DataTable(
                      columnSpacing: columnSpacing,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
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
                                  Text(student.rollNo),
                                  onTap: () => navigateToDetail(student),
                                ),
                                DataCell(
                                  Text(student.name),
                                  onTap: () => navigateToDetail(student),
                                ),
                                DataCell(
                                  Text(student.grade),
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
      ),
    );
  }
}
