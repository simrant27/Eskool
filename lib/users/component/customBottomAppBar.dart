// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../data/menuItems.dart';
import '../screen/parentsdashboard.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // List of specific items to be displayed in reverse order
    List<MenuItem> reversedItems = menuItems(context).where((item) {
      return item.title == 'Chat' ||
          item.title == 'Notification' ||
          item.title == 'Profile';
    }).toList();

    // Reverse the order of the items
    reversedItems = reversedItems.reversed.toList();

    return BottomAppBar(
      child: Row(
        children: [
          // IconButton(
          //   icon: Icon(Icons.home, size: 30),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => Parentsdashboard()),
          //     );
          //   },
          // ),
          SizedBox(
            width: 20,
          ),
          // Expanded to allow horizontal arrangement of icons with space between them
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: reversedItems.map((menuItem) {
                return IconButton(
                  icon: Icon(menuItem.icon, size: 30),
                  onPressed: () => menuItem.onTap(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
