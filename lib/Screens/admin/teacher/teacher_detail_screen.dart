import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../models/teacherModel.dart';
import 'show_image.dart';

class TeacherDetailScreen extends StatelessWidget {
  final Teacher teacher;

  TeacherDetailScreen({required this.teacher});

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
      content: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 230, 238, 248),
          title: Text("Hi ${teacher.fullName}!" ?? 'Teacher Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              // if (teacher.image != null) ...[
              //   // For image files
              //   if (teacher.image!.endsWith('.jpg') ||
              //       teacher.image!.endsWith('.png') ||
              //       teacher.image!.endsWith('.jpeg')) ...[
              //     Container(child: showImage(teacher.image, "teacher")),
              //   ]
              // ],
              if (teacher.image != null) ...[
                if (teacher.image!.endsWith('.jpg') ||
                    teacher.image!.endsWith('.png') ||
                    teacher.image!.endsWith('.jpeg')) ...[
                  Container(
                    width: 80, // Set a specific width for the container
                    height: 80, // Set a specific height for the container
                    decoration: BoxDecoration(
                      // shape: BoxShape.squa, // Make the container circular
                      color: Colors.grey[200], // Set a background color
                    ),
                    alignment: Alignment
                        .center, // Center the image within the container

                    child: showImage(teacher.image, "teacher"),
                  ),
                ],
              ],

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
      ),
    );
  }
}
