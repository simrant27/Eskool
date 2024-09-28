// ignore_for_file: prefer_const_constructors

import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:flutter/material.dart';


class StudentDetailScreen extends StatelessWidget {
  final String studentName;
  final String studentGrade;
  final Map<String, dynamic> studentDetails;

  StudentDetailScreen({
    required this.studentName,
    required this.studentGrade,
    required this.studentDetails,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $studentName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Grade: $studentGrade',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(studentDetails.toString()), // Format as needed
          ],
        ),
      ),appbartitle: "Student Detail", showArrow: true);
  }
}
