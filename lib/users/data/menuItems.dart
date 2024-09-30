import 'package:eskool/users/screen/UploadStudyMaterial.dart';
import 'package:eskool/users/screen/material.dart';
import 'package:eskool/users/screen/teacher_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/loginService.dart';
import '../component/CustomAlertDialogBox.dart';
import '../component/StudentListScreen.dart';
import '../screen/FetchNoticeByUser.dart';
import '../screen/StudentDetail.dart';
import '../screen/finance.dart';
import '../screen/parent_profile.dart';
import '../screen/Parentsdashboard.dart';
import 'package:flutter/material.dart';

import '../screen/teacherScreen.dart';

class MenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

Future<List<MenuItem>> menuItems(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userRole = prefs.getString('role'); // Get user role

  List<MenuItem> items = [
    MenuItem(
      icon: Icons.dashboard,
      title: 'Dashboard',
      onTap: () {
        if (userRole == 'parent') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Parentsdashboard()),
          );
        } else if (userRole == 'teacher') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeacherDashboard()),
          );
        }
      },
    ),
    MenuItem(
      icon: Icons.person,
      title: 'Profile',
      onTap: () {
        if (userRole == 'parent') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ParentProfile()),
          );
        } else if (userRole == 'teacher') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeacherProfile()),
          );
        }
      },
    ),
    MenuItem(
      icon: Icons.notifications_active_sharp,
      title: 'Notification',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FetchNoticeByUser()),
        );
      },
    ),
    MenuItem(
      icon: Icons.chat,
      title: 'Chat',
      onTap: () {
        // Handle the tap event
      },
    ),
    MenuItem(
      icon: Icons.assignment,
      title: 'Assignment',
      onTap: () {
        // Handle assignment navigation
      },
    ),
    MenuItem(
      icon: Icons.assignment,
      title: 'Result',
      onTap: () {},
    ),
    MenuItem(
      icon: Icons.book_online_rounded,
      title: 'Materials',
      onTap: () {
        if (userRole == 'parent') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MaterialListScreen()),
          );
        } else if (userRole == 'teacher') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UploadStudyMaterialScreen()),
          );
        }
      },
    ),
    MenuItem(
      icon: Icons.logout,
      title: 'Logout',
      onTap: () {
        customAlertDialogBox(
          context,
          "Log Out",
          "Are You Sure?!",
          [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await LoginService().logout(); // Call the logout method
                Navigator.pushReplacementNamed(
                    context, '/login'); // Navigate to login page
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    ),
  ];

  // Conditionally add "Child Details" and "Finance" for parents only
  if (userRole == 'parent') {
    items.insert(
        4,
        MenuItem(
          icon: Icons.details,
          title: 'Child Details',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentListWidget(
                  onSelectRoute: (student) => StudentDetailScreen(
                    studentName: student['fullName'],
                    studentGrade: student['classAssigned'].toString(),
                    studentId: student["id"].toString(),
                  ),
                ),
              ),
            );
          },
        ));

    items.insert(
      5,
      MenuItem(
        icon: Icons.attach_money_sharp,
        title: 'Finance',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentListWidget(
                onSelectRoute: (student) => FinanceBillScreen(
                  studentId: student['id'],
                  studentName: student['fullName'],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  return items;
}
