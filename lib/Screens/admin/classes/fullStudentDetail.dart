import 'package:eskool/Screens/admin/admindashboard/components/customAppbar.dart';
import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';
import 'package:flutter/material.dart';
import 'package:eskool/models/Students_model.dart'; // Adjust import as needed

class FullStudentDetail extends StatelessWidget {
  final Student student;

  const FullStudentDetail({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
      content: Column(
        children: [
          CustomAppbar(
            hinttext: "hi",
            showSearch: false,
            showBackButton: true,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Roll No: ${student.rollNo}",
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text("Grade: ${student.grade}", style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text("Parent Name: ${student.parentName}",
                    style: TextStyle(fontSize: 18)),
                // Add more fields as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
