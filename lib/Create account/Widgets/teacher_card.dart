import 'package:flutter/material.dart';

class TeacherCard extends StatelessWidget {
  final Map<String, dynamic> teacher;

  TeacherCard({required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${teacher['fullName']}', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Email: ${teacher['email']}'),
            Text('Phone: ${teacher['phone']}'),
            Text('Subjects: ${teacher['subjects']}'),
          ],
        ),
      ),
    );
  }
}
