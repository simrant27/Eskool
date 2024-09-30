// ignore_for_file: prefer_const_constructors

import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:eskool/users/component/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../component/Logout_profile.dart';
import '../component/introduction.dart';
import '../data/userImage.dart';
import '../forBackend/fetchTeachersByid.dart';
import '../forBackend/teacher_model.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({super.key});

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  Teacher? teacher;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTeacher();
  }

  Future<void> _loadTeacher() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? teacherId = prefs
        .getString('userId'); // Fetch the teacher ID from shared preferences

    if (teacherId != null && teacherId.isNotEmpty) {
      print("SharedPreference Teacher ID: $teacherId");
      await fetchTeacher(teacherId);
    } else {
      print('Teacher ID is null or empty');
      setState(() {
        errorMessage = 'Teacher ID not found';
      });
    }
  }

  Future<void> fetchTeacher(String? teacherId) async {
    setState(() {
      isLoading = true; // Show loading indicator while fetching
      errorMessage = null; // Reset error message
    });

    try {
      var fetchedTeacher =
          await fetchTeachers(teacherId!); // Fetch teacher data
      setState(() {
        teacher = fetchedTeacher; // Update the teacher state with fetched data
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Error fetching teacher data: $error';
      });
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar("Teacher Profile"),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while fetching data
          : errorMessage != null // If there's an error, show a message
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 18)),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed:
                            _loadTeacher, // Retry fetching the teacher data
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : teacher != null // If teacher data is available
                  ? ListView(
                      padding: EdgeInsets.all(16.0),
                      children: [
                        // Teacher Profile Image
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 1, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.2),
                                  blurRadius: 12,
                                  spreadRadius: 8,
                                ),
                              ],
                              image: UserImageLoader.userImage(teacher!.image),
                            ),
                          ),
                        ),
                        SizedBox(height: 40), // Add spacing
                        Introduction(
                          true,
                          teacher?.fullName ?? 'N/A',
                          teacher?.email ?? 'N/A',
                          teacher?.phone ?? 'N/A',
                        ),
                        SizedBox(height: 16),
                        // Logout List Tile
                        Logout_profile(context),
                      ],
                    )
                  : Center(
                      child: Text('No teacher data available'),
                    ),
    );
  }
}
