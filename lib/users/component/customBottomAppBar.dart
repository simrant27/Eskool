import 'package:flutter/material.dart';
import '../data/menuItems.dart';
import '../screen/parentsdashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/teacherScreen.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

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

    return FutureBuilder<String?>(
      future: getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        String? userRole = snapshot.data;

        return BottomAppBar(
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.home, size: 30),
                onPressed: () {
                  if (userRole == 'parent') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Parentsdashboard()),
                    );
                  } else if (userRole == 'teacher') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TeacherDashboard()),
                    );
                  }
                },
              ),
              SizedBox(width: 20),
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
      },
    );
  }
}
