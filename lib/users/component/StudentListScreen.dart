import 'dart:convert';
import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:eskool/users/component/customAppBar2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Screens/admin/billing/data/studentList.dart';
import '../forBackend/fetchstudentAsParent.dart';

class StudentListWidget extends StatefulWidget {
  final Widget Function(Map<String, dynamic> student) onSelectRoute;

  StudentListWidget({required this.onSelectRoute});

  @override
  State<StudentListWidget> createState() => _StudentListWidgetState();
}

class _StudentListWidgetState extends State<StudentListWidget> {
  List<Student> students = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadParentAndFetchStudents();
  }

  Future<void> _loadParentAndFetchStudents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? parentID = prefs.getString('userId');

    if (parentID != null && parentID.isNotEmpty) {
      print("sharePrefrence $parentID");
      await fetchStudentParentId(parentID);
    } else {
      // Handle the case where parentID is not found
      print('Parent ID is null or empty');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Parent ID not found')),
      );
    }
  }

  Future<void> fetchStudentParentId(String selectedParent) async {
    setState(() {
      isLoading = true; // Show loading indicator while fetching
      print('Fetching students for parent: $selectedParent');
    });

    try {
      // Directly fetch students for the selected Parent from the API
      List<Student> fetchedStudents =
          await fetchStudentsByParentId(selectedParent);

      setState(() {
        students = fetchedStudents;
        isLoading = false; // Hide loading indicator
        print('$students');
      });
    } catch (error) {
      setState(() {
        isLoading = false; // Hide loading indicator on error
      });
      print('Error occurred: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching students: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          Center(
            child: Text(
              "Please select a student",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 40),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return GestureDetector(
                        onTap: () {
                          print("from student page ${student.id}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => widget.onSelectRoute({
                                'id': student.id,
                                'fullName': student.fullName,
                                "classAssigned": student.classAssigned
                              }),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10), // Adjust margin for spacing
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 127, 195, 224),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              student
                                  .fullName, // Access fullName directly from the Student object
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
      appBar: customAppBar2("Select Student"),
    );
  }
}
