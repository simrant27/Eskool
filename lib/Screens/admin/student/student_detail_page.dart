import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';
import 'package:eskool/constants/responsive.dart'; // Assumed package for checking desktop/mobile
import 'package:flutter/material.dart';
import '../../../models/Students_model.dart';
import '../teacher/show_image.dart';

class StudentDetailPage extends StatelessWidget {
  final Student student;

  StudentDetailPage({required this.student});

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
        content: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 230, 238, 248),
        title: Text("Hi ${student.fullName}!" ?? 'Student Details'),
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

      // If student has an image
      if (student.image != null) ...[
        // For image files (only showing for images ending with jpg/png/jpeg)
        if (student.image!.endsWith('.jpg') ||
            student.image!.endsWith('.png') ||
            student.image!.endsWith('.jpeg')) ...[
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
              child: showImage(student.image, "student")),
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

      // student Details Container
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
                  'Full Name: ${student.fullName ?? 'N/A'}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),

            Text(
              'Phone: ${student.classAssigned ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),

            Text(
              'Address: ${student.address ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Qualifications: ${student.studentId ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
             Text(
              'Qualifications: ${student.gender ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            
            // Uncomment if you want to display enrolled status
            // Text(
            //   'Enrolled: ${student.enrolled! ? 'Yes' : 'No'}',
            //   style: TextStyle(fontSize: 18),
            // ),
          ],
        ),
      ),
    ];
  }
}
