// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../component/Drawerlist.dart';
import '../component/buildProfileSection.dart';
import '../component/buildSecuritySection.dart';
import '../component/customAppBar.dart';
import '../component/customBottomAppBar.dart';
import '../data/menuItems.dart';
import '../data/student.dart';
import '../data/userImage.dart';
import 'StudentDetail.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    // Get logout item
    final logout =
        menuItems(context).where((item) => item.title == 'Logout').toList();

    return Scaffold(
      appBar: customAppBar("Profile"),
      drawer: drawerlist(context),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Profile Image
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
                  image: userImage()),
            ),
          ),

          SizedBox(height: 40), // Add some spacing

          // Personal Information
          buildProfileSection("Personal Information", context),
          SizedBox(height: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Linked Students",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // Prevent inner scrolling
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return ListTile(
                    leading: Icon(Icons.child_care, color: Colors.blue),
                    title:
                        Text(student['name'], style: TextStyle(fontSize: 18)),
                    subtitle: Text('Grade : ${student['grade']}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentDetailScreen(
                            studentName: student['name'],
                            studentGrade: student['grade'].toString(),
                            studentDetails: student,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16),

          // Security & Privacy
          buildSecuritySection(context),
          SizedBox(height: 16),

          // Logout List Tile
          ListView.builder(
            shrinkWrap: true, // To allow nested ListView inside ListView
            physics: NeverScrollableScrollPhysics(), // Prevent inner scrolling
            itemCount: logout.length,
            itemBuilder: (context, index) {
              MenuItem item = logout[index];
              return ListTile(
                onTap: item.onTap,
                leading: Icon(
                  item.icon,
                  color: Colors.blue,
                  size: 25,
                ),
                title: Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
