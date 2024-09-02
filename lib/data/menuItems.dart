import '../screen/profile.dart';
import '../screen/studentdashboard.dart';
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
          MaterialPageRoute(builder: (context) => Studentdashboard()),
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
      icon: Icons.assignment,
      title: 'Assignment',
      onTap: () {
        // Handle the tap event
      },
    ),
    MenuItem(
      icon: Icons.attach_money_sharp,
      title: 'Finance',
      onTap: () {
        // Handle the tap event
      },
    ),
    MenuItem(
      icon: Icons.logout,
      title: 'Logout',
      onTap: () {
        // Handle the tap event
      },
    ),
  ];
}
