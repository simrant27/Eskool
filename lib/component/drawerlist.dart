
import 'package:flutter/material.dart';

import '../data/data.dart';
import 'boxDesign.dart';

Drawer drawerlist() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: boxDesign(),
          child: Column(
            children: [
              introduction['greeting']!,
              SizedBox(height: 10),
              introduction['RegNO']!,
              SizedBox(height: 6),
              introduction['Standard']!,
              SizedBox(height: 8)
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.dashboard),
          title: Text('Dashboard'),
          onTap: () {
            // Handle the tap event
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Profile'),
          onTap: () {
            // Handle the tap event
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications_active_sharp),
          title: Text('Notification'),
          onTap: () {
            // Handle the tap event
          },
        ),
        ListTile(
          leading: Icon(Icons.assignment),
          title: Text('Assignment'),
          onTap: () {
            // Handle the tap event
          },
        ),
        ListTile(
          leading: Icon(Icons.attach_money_sharp),
          title: Text('Finance'),
          onTap: () {
            // Handle the tap event
          },
        ),
        ListTile(
          leading: Icon(Icons.chat),
          title: Text('Chat'),
          onTap: () {
            // Handle the tap event
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {
            // Handle the tap event
          },
        ),
      ],
    ),
  );
}
