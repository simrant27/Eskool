import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/menuItems.dart';
import '../screen/parentsdashboard.dart';
import '../screen/teacherScreen.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  // Function to retrieve the user's role from SharedPreferences
  Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  @override
  Widget build(BuildContext context) {
    // Build the widget tree
    return FutureBuilder<String?>(
      future: getUserRole(), // Get user role asynchronously
      builder: (context, roleSnapshot) {
        if (roleSnapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while the role is being fetched
          return CircularProgressIndicator();
        }

        String? userRole = roleSnapshot.data; // Get the fetched user role

        return FutureBuilder<List<MenuItem>>(
          future: menuItems(context), // Fetch the menu items asynchronously
          builder: (context, menuSnapshot) {
            if (menuSnapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while fetching menu items
              return CircularProgressIndicator();
            } else if (menuSnapshot.hasError) {
              return Center(
                child: Text('Error: ${menuSnapshot.error}'),
              ); // Show error if fetching fails
            } else if (!menuSnapshot.hasData || menuSnapshot.data!.isEmpty) {
              return Center(child: Text('No menu items available'));
            } else {
              // Extract menu items and filter for specific items (Chat, Notification, Profile)
              List<MenuItem> reversedItems = menuSnapshot.data!
                  .where((item) {
                    return item.title == 'Chat' ||
                        item.title == 'Notification' ||
                        item.title == 'Profile';
                  })
                  .toList()
                  .reversed
                  .toList(); // Reverse the filtered items

              return BottomAppBar(
                child: Row(
                  children: [
                    // Home button with role-based navigation
                    IconButton(
                      icon: Icon(Icons.home, size: 30),
                      onPressed: () {
                        if (userRole == 'parent') {
                          // Navigate to Parentsdashboard if user is a parent
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Parentsdashboard()),
                          );
                        } else if (userRole == 'teacher') {
                          // Navigate to TeacherDashboard if user is a teacher
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeacherDashboard()),
                          );
                        }
                      },
                    ),
                    SizedBox(width: 20), // Add spacing between icons

                    // Render filtered and reversed menu items
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
          },
        );
      },
    );
  }
}
