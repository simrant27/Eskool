import 'package:flutter/material.dart';

import '../data/data.dart';
import '../data/menuItems.dart';
import 'boxDesign.dart';

Drawer drawerlist(BuildContext context) {
  // Retrieve the menu items once and reuse
  final items = menuItems(context);

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: boxDesign(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              introduction['greeting'] ??
                  Text('Welcome!'), // Added a default message
              SizedBox(height: 10),
              introduction['RegNO'] ??
                  Text('Registration Number not available'),
              SizedBox(height: 6),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(items[index].icon), // Use 'items' variable here
              title: Text(items[index].title),
              onTap: items[index].onTap,
            );
          },
        ),
      ],
    ),
  );
}
