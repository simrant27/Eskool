import 'package:flutter/material.dart';
import '../../../models/teacherModel.dart';

class TeacherDetailScreen extends StatelessWidget {
  final Teacher teacher;

  TeacherDetailScreen({required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(teacher.fullName ?? 'Teacher Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Teacher Image
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    AssetImage("assets/images/default_profile.png"),
                // backgroundImage: teacher.image != null
                //     ? NetworkImage(teacher.image!) // Assuming image is a URL
                //     : AssetImage('assets/images/default_profile.png')
                //         as ImageProvider, // Default image if no image available
              ),
            ),
            SizedBox(height: 16),
            // Display Teacher Details
            Text(
              'Full Name: ${teacher.fullName ?? 'N/A'}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Email: ${teacher.email ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Phone: ${teacher.phone ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Username: ${teacher.username ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Address: ${teacher.address ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Qualifications: ${teacher.qualifications?.join(', ') ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Subjects Taught: ${teacher.subjectsTaught?.join(', ') ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Enrolled: ${teacher.enrolled! ? 'Yes' : 'No'}',
              style: TextStyle(fontSize: 18),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
