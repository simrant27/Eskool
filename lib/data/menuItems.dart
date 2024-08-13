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

List<MenuItem> menuItems = [
  MenuItem(
    icon: Icons.dashboard,
    title: 'Dashboard',
    onTap: () {
      // Handle the tap event
    },
  ),
  MenuItem(
    icon: Icons.person,
    title: 'Profile',
    onTap: () {
      // Handle the tap event
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
