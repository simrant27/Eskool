// ignore_for_file: prefer_const_constructors

import 'package:eskool/users/component/CustomScaffold.dart';
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
      // Handle the case where teacherId is not found
      print('Teacher ID is null or empty');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Teacher ID not found')),
      );
    }
  }

  Future<void> fetchTeacher(String teacherId) async {
    setState(() {
      isLoading = true; // Show loading indicator while fetching
      print('Fetching Teacher with ID: $teacherId');
    });

    try {
      // Fetch teacher data using the provided teacher ID
      var fetchedTeacher = await fetchTeachers(
          teacherId); // Assuming fetchTeachers is the API call to get the teacher data

      setState(() {
        teacher = fetchedTeacher; // Update the teacher state with fetched data
        isLoading = false; // Hide loading indicator
        print('Fetched Teacher: $teacher');
      });
    } catch (error) {
      setState(() {
        isLoading = false; // Hide loading indicator on error
      });
      print('Error occurred while fetching teacher: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching teacher data: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Show a loader while fetching data
          : teacher != null // Check if teacher is fetched and not null
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
                          image:
                              userImage(), // You might want to pass teacher's image here
                        ),
                      ),
                    ),

                    SizedBox(height: 40), // Add some spacing

                    // Personal Information Section (Only build if teacher is not null)
                    Introduction(
                      true,
                      teacher!
                          .fullName, // Access teacher's properties safely now
                      teacher!.email,
                      teacher!.phone,
                    ),

                    SizedBox(height: 16),

                    // Logout List Tile
                    Logout_profile(context),                  ],
                )
              : Center(
                  child: Text(
                      'No teacher data available'), // Placeholder if teacher is null
                ),
      appbartitle: "Teacher Profile",
      showArrow: false,
    );
  }
}
