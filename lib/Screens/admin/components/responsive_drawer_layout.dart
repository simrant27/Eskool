import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../constants/responsive.dart';
import '../../../controllers/drawerController.dart';

import 'drawerMenu.dart';

class ResponsiveDrawerLayout extends StatelessWidget {
  final Widget content; // The content to display next to the drawer

  const ResponsiveDrawerLayout({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: DrawerMenu(),
      key: context.read<Controller>().scaffoldKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Container(
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
                child: DrawerMenu(),
              ),
            Expanded(flex: 5, child: content),
          ],
        ),
      ),
    );
  }
}
