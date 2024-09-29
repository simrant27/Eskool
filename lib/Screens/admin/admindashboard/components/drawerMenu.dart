import 'package:eskool/Screens/admin/admindashboard/admindashboard.dart';
import 'package:eskool/Screens/admin/admindashboard/components/dashboard_content.dart';
import 'package:eskool/Screens/admin/admindashboard/components/drawer_list_title.dart';
import 'package:eskool/Screens/admin/billing/billing_page.dart';
import 'package:eskool/Screens/admin/classes/student_deatail.dart';
import 'package:eskool/Screens/admin/parents/parent_list_screen.dart';
import 'package:eskool/Screens/admin/teacher/teacher_list_screen.dart';
import 'package:eskool/constants/constants.dart';
import 'package:eskool/data/class_list.dart';
import 'package:eskool/models/Students_model.dart';
import 'package:flutter/material.dart';

import '../../../../services/loginService.dart';
import '../../../../users/component/CustomAlertDialogBox.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: secondaryColor,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(appPadding),
            child: Image.asset(
              "assets/images/logowithtext.png",
              // width: 100.0,
              height: 100.0,
            ),
          ),
          DrawerListTitle(
              title: "DashBoard",
              icon: Icons.dashboard,
              tap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Admindashboard()));
              }),
          DrawerListTitle(
              title: "Teacher",
              icon: Icons.person_2,
              tap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeacherListScreen()));
              }),
          DrawerListTitle(
              title: "Parents",
              icon: Icons.people_alt_sharp,
              tap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ParentListScreen()));
              }),
          // DrawerListTitle(
          //     title: "Classes", icon: Icons.class_outlined, tap: () {}),
          ExpansionTile(
            title: Text("Classes"),
            leading: Icon(
              Icons.class_outlined,
              color: Colors.blueGrey.shade300,
            ),
            children: classList.map((className) {
              return ListTile(
                title: Text(className),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentDetail(className: className),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          DrawerListTitle(
              title: "Billing",
              icon: Icons.file_copy_sharp,
              tap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BillingPage()));
              }),

          DrawerListTitle(
              title: "Logout",
              icon: Icons.logout,
              tap: () {
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
              }),
        ],
      ),
    );
  }
}
