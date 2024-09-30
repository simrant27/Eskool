import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';
import 'package:eskool/constants/responsive.dart'; // Assumed package for checking desktop/mobile
import 'package:flutter/material.dart';
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Responsive.isDesktop(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildContent(context),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildContent(context),
                ),
        ),
      ),
    ));
  }

  // Helper function to return the list of widgets for both Row and Column
  List<Widget> buildContent(BuildContext context) {
    return [
      SizedBox(height: 20),

      // If teacher has an image
      if (teacher.image != null) ...[
        // For image files (only showing for images ending with jpg/png/jpeg)
        if (teacher.image!.endsWith('.jpg') ||
            teacher.image!.endsWith('.png') ||
            teacher.image!.endsWith('.jpeg')) ...[
          Container(
              width: MediaQuery.of(context).size.height / 2,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.2),
                      blurRadius: 12,
                      spreadRadius: 8,
                    ),
                  ]),
              child: showImage(teacher.image, "teacher")),
        ]
      ],

      // Adding a SizedBox to provide some space between the content
      if (Responsive.isDesktop(context)) SizedBox(width: 20),

      // Vertical Divider only on Desktop
      if (Responsive.isDesktop(context))
        VerticalDivider(
          color: Colors.black12,
          thickness: 1,
          width: 20,
          indent: 10,
          endIndent: 10,
        ),

      // Teacher Details Container
      Container(
        padding: Responsive.isDesktop(context)
            ? EdgeInsets.all(80)
            : EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Full Name: ${teacher.fullName ?? 'N/A'}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
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
            // Uncomment if you want to display enrolled status
            // Text(
            //   'Enrolled: ${teacher.enrolled! ? 'Yes' : 'No'}',
            //   style: TextStyle(fontSize: 18),
            // ),
          ],
        ),
      ),
    ];
  }
}
