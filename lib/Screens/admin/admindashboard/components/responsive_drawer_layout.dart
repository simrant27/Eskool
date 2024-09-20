import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/responsive.dart';

import 'drawerMenu.dart';

class ResponsiveDrawerLayout extends StatelessWidget {
  final Widget content;

  const ResponsiveDrawerLayout({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      // Only show the drawer on mobile and tablet screens
      drawer: Responsive.isDesktop(context) ? null : DrawerMenu(),
      // Use the AppBar to handle drawer opening in mobile mode
      appBar: Responsive.isDesktop(context)
          ? null
          : AppBar(
              backgroundColor: bgColor,
              title: Text('Dashboard'),
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); // Opens the drawer
                    },
                  );
                },
              ),
            ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sidebar only for desktop screens
            if (Responsive.isDesktop(context))
              Container(
                width: 250, // Fixed width for the sidebar
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(3, 0),
                    ),
                  ],
                ),
                child: DrawerMenu(), // Sidebar content
              ),
            // The main content
            Expanded(
              flex: 5,
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
