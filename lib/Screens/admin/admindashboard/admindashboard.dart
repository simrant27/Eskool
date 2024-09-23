import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eskool/Screens/admin/admindashboard/components/dashboard_content.dart';
import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';

class Admindashboard extends StatelessWidget {
  const Admindashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
      content: DashboardContent(),
    );
  }
}
