import 'dart:convert';

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
              introduction['greeting'] ?? Text(''), // Ensure fallback values
              SizedBox(height: 10),
              introduction['email'] ?? Text(''),
              SizedBox(height: 6),
              introduction['number'] ?? Text(''),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(items[index].icon,
                  color: Colors.black87), // Use 'items' variable here
              title: Text(
                items[index].title,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onTap: items[index].onTap,
            );
          },
        ),
      ],
    ),
  );
}
