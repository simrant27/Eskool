import 'package:flutter/material.dart';

final List<MenuItem> menuItems = [
  MenuItem(title: 'Dashboard', icon: Icons.dashboard),
  MenuItem(title: 'Profile', icon: Icons.person),
  MenuItem(title: 'Notification', icon: Icons.notifications_active_sharp),
  MenuItem(title: 'Assignment', icon: Icons.assignment),
  MenuItem(title: 'Finance', icon: Icons.attach_money_sharp),
  MenuItem(title: 'Chat', icon: Icons.chat),
  MenuItem(title: 'Logout', icon: Icons.logout),
];

class MenuItem {
  final String title;
  final IconData icon;

  MenuItem({required this.title, required this.icon});
}
