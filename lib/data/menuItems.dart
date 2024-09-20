import 'package:eskool_asmita/screen/StudentDetail.dart';

import '../component/CustomAlertDialogBox.dart';
import '../component/StudentListScreen.dart';
import '../screen/finance.dart';
import '../screen/profile.dart';
import '../screen/parentsdashboard.dart';
import 'package:flutter/material.dart';

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

List<MenuItem> menuItems(BuildContext context) {
  return [
    MenuItem(
      icon: Icons.dashboard,
      title: 'Dashboard',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => parentsdashboard()),
        );
      },
    ),
    MenuItem(
      icon: Icons.person,
      title: 'Profile',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
        );
      },
    ),
    MenuItem(
      icon: Icons.notifications_active_sharp,
      title: 'Notification',
      onTap: () {
        // Handle the tap event
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
      icon: Icons.details,
      title: 'Child Details',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StudentListWidget(
                    onSelectRoute: (student) => StudentDetailScreen(
                      studentName: student['name'],
                      studentGrade: student['grade'].toString(),
                      studentDetails: student,
                    ),
                  )),
        );
      },
    ),
    MenuItem(
      icon: Icons.assignment,
      title: 'Assignment',
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => StudentListWidget()),
        // );
      },
    ),
    MenuItem(
      icon: Icons.attach_money_sharp,
      title: 'Finance',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StudentListWidget(
                    onSelectRoute: (student) => FinanceBillScreen(
                      studentName: student['name'],
                      billItems: student['items'],
                      totalAmount: student['fees'],
                    ),
                  )),
        );
      },
    ),
    MenuItem(
      icon: Icons.book_online_rounded,
      title: 'Materials',
      onTap: () {},
    ),
    MenuItem(
      icon: Icons.logout,
      title: 'Logout',
      onTap: () {
        CustomAlertDialogBox(
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
              onPressed: () {
                // Add logout functionality here
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    ),
  ];
}
