// ignore_for_file: prefer_const_constructors

import 'package:eskool/users/component/introduction.dart';
import 'package:flutter/material.dart';

import '../data/data.dart';
import '../data/menuItems.dart';
import 'boxDesign.dart';

Drawer CustomDrawerForUser(
    BuildContext context, String fullName, String email, String phone) {
  // Retrieve the menu items once and reuse
  final items = menuItems(context);

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            decoration: boxDesign(),
            child: Introduction(fullName, email, phone)),
        FutureBuilder<List<MenuItem>>(
          future: menuItems(context), // Fetch the menu items
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator()); // Loading indicator
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error: ${snapshot.error}')); // Error handling
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text('No menu items available')); // No items case
            } else {
              // Access the menu items after they're fetched
              List<MenuItem> items = snapshot.data!;

              // Example: Accessing the first menu item
              MenuItem firstItem = items[0];

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  MenuItem menuItem =
                      items[index]; // Access individual item by index

                  return ListTile(
                    leading: Icon(menuItem.icon, color: Colors.black87),
                    title: Text(menuItem.title, style: TextStyle(fontSize: 22)),
                    onTap: menuItem.onTap, // Handle tap event for the item
                  );
                },
              );
            }
          },
        )
      ],
    ),
  );
}
