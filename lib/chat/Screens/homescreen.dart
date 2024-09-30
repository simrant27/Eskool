import 'package:eskool/services/teacherService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/chat_model.dart';
import '../../models/teacherModel.dart'; // Make sure to import your Teacher model

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userRole});
  final String userRole;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Teacher> teachers = [];
  bool isLoading = true; // To show a loading indicator
  TeacherService teacherService = TeacherService();
  @override
  void initState() {
    super.initState();
    if (widget.userRole == "parent") {
      fetchTeachers();
    }
  }

  Future<void> fetchTeachers() async {
    try {
      final response =
          await teacherService.fetchTeachers(); // Call your fetch function here
      setState(() {
        teachers = response; // Update the state with the fetched teachers
        isLoading = false; // Stop loading
      });
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false; // Stop loading on error
      });
      print('Error fetching teachers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text(
          widget.userRole == "parent" ? "Teachers" : "Parents",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : ListView.builder(
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                final teacher = teachers[index];
                return ListTile(
                  title: Text(teacher
                      .fullName!), // Adjust according to your Teacher model fields
                );
              },
            ),
    );
  }
}
