import 'package:eskool/Screens/admin/components/dashboard_content.dart';
import 'package:eskool/constants/constants.dart';
import 'package:eskool/constants/responsive.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import '../../controllers/drawerController.dart';
import 'components/drawerMenu.dart';
import 'package:provider/provider.dart';

class Admindashboard extends StatefulWidget {
  const Admindashboard({super.key});

  @override
  State<Admindashboard> createState() => _AdmindashboardState();
}

class _AdmindashboardState extends State<Admindashboard> {
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
                    color: Colors.white, // Background color of the drawer
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(3, 0), // Shadow direction
                      ),
                    ],
                  ),
                  child: DrawerMenu(),
                ),
              Expanded(flex: 5, child: DashboardContent())
            ],
          ),
        ));
  }
}
