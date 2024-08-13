import 'package:flutter/material.dart';

import '../data/data.dart';
import '../data/menuItems.dart';
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
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(menuItems[index].icon),
              title: Text(menuItems[index].title),
              onTap: menuItems[index].onTap,
            );
          },
        ),
      ],
    ),
  );
}
