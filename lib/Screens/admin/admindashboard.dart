import 'package:eskool/Screens/admin/components/dashboard_content.dart';
import 'package:eskool/Screens/admin/components/responsive_drawer_layout.dart';
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
    return ResponsiveDrawerLayout(content: DashboardContent());
  }
}
