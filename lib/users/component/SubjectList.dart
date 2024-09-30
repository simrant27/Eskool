import 'package:eskool/users/screen/resultAssign.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../forBackend/fetchTeachersByid.dart';
import '../forBackend/teacher_model.dart';
import 'CustomScaffold.dart';
import 'RectangleBox.dart';
import 'customAppBar2.dart';

class SubjectList extends StatefulWidget {
  const SubjectList({super.key});

  @override
  State<SubjectList> createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  List<String> subject = [];
  bool isLoading = false;
  String? teacherID;

  @override
  void initState() {
    super.initState();
    _subjectList();
  }

  Future<void> _subjectList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    teacherID = prefs.getString('userId');

    if (teacherID != null && teacherID!.isNotEmpty) {
      print("SharedPreference Teacher ID: $teacherID");
      await fetchSubject(teacherID!);
    } else {
      // Handle the case where teacherID is not found
      print('teacherID is null or empty');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Teacher ID not found')),
      );
    }
  }

  Future<void> fetchSubject(String selectTeacher) async {
    setState(() {
      isLoading = true; // Show loading indicator while fetching
      print('Fetching subjects for teacher: $selectTeacher');
    });

    try {
      // Fetch the teacher data from the API
      Teacher? fetchedTeacher = await fetchTeachers(selectTeacher);

      if (fetchedTeacher != null && fetchedTeacher.subjectsTaught.isNotEmpty) {
        setState(() {
          // Flatten the nested list (e.g., [["math", "Science"]] to ["math", "Science"])
          subject = fetchedTeacher.subjectsTaught;
          // .expand((sublist) => sublist)
          // .toList();
          isLoading = false; // Hide loading indicator
          print('Flattened Subjects: ${subject[0]} ${subject[0].length}');
        });
      } else {
        throw Exception("No subjects found for this teacher.");
      }
    } catch (error) {
      setState(() {
        isLoading = false; // Hide loading indicator on error
      });
      print('Error occurred: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching subjects: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Center(
            child: Text(
              "Please select a Subject",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 40),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: subject.length,
                    itemBuilder: (context, index) {
                      final selectedSubject = subject[index];
                      return GestureDetector(
                        onTap: () {
                          if (teacherID != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Resultassign(
                                  subject: selectedSubject,
                                  teacherId: teacherID!,
                                ),
                              ),
                            );
                          }
                        },
                        child: RectangleBox(
                          selectedSubject, // Assuming RectangleBox has a title parameter
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
      appBar: customAppBar2("Select Subject"),
    );
  }
}
