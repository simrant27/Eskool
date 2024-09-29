// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../data/menuItems.dart';
import 'boxDesign.dart';

Drawer CustomDrawerForUser(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        DrawerHeader(
          decoration: boxDesign(),
          child: Text(
            "Welcome to Eskool",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Color(0XFF343E87),
            ),
          ),
        ),
        Expanded(
          // Use Expanded to constrain the ListView
          child: FutureBuilder<List<MenuItem>>(
            future: menuItems(context), // Fetch menu items asynchronously
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator()); // Loading state
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Error: ${snapshot.error}')); // Error state
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                List<MenuItem> items = snapshot.data!;

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    MenuItem menuItem =
                        items[index]; // Access individual item by index

                    return ListTile(
                      leading: Icon(menuItem.icon, color: Colors.black87),
                      title:
                          Text(menuItem.title, style: TextStyle(fontSize: 22)),
                      onTap: menuItem.onTap, // Handle tap event for the item
                    );
                  },
                );
              } else {
                return Center(child: Text('No menu items available'));
              }
            },
          ),
        ),
      ],
    ),
  );
}
