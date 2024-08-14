import 'package:eskool/Screens/admin/admindashboard.dart';
import 'package:eskool/Screens/admin/components/dashboard_content.dart';
import 'package:eskool/Screens/admin/components/drawer_list_title.dart';
import 'package:eskool/constants/constants.dart';
import 'package:flutter/material.dart';

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
          DrawerListTitle(title: "Teacher", icon: Icons.person_2, tap: () {}),
          DrawerListTitle(
              title: "Parents", icon: Icons.people_alt_sharp, tap: () {}),
          DrawerListTitle(title: "Logout", icon: Icons.logout, tap: () {}),
        ],
      ),
    );
  }
}
