import 'package:flutter/material.dart';

import '../data/menuItems.dart';

FutureBuilder<List<MenuItem>> Logout_profile(BuildContext context) {
  return FutureBuilder<List<MenuItem>>(
    future: menuItems(context), // Fetch menu items asynchronously
    builder: (context, menuSnapshot) {
      if (menuSnapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator()); // Loading menu items
      } else if (menuSnapshot.hasError) {
        return Center(
          child: Text('Error: ${menuSnapshot.error}'),
        ); // Error loading menu items
      } else if (menuSnapshot.hasData && menuSnapshot.data != null) {
        List<MenuItem> logoutItems = menuSnapshot.data!.where((item) {
          return item.title == 'Logout';
        }).toList();

        // Assuming there's only one logout item
        if (logoutItems.isNotEmpty) {
          final logoutItem = logoutItems.first;

          return ListTile(
            leading: Icon(logoutItem.icon, color: Colors.black87),
            title: Text(logoutItem.title, style: TextStyle(fontSize: 22)),
            onTap: logoutItem.onTap, // Handle tap event for the item
          );
        }
      }
      return SizedBox(); // Return an empty widget if no logout item found
    },
  );
}
