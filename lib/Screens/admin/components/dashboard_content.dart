import 'package:eskool/Screens/admin/components/customAppbar.dart';
import 'package:eskool/constants/constants.dart';
import 'package:flutter/material.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding),
        child: Column(
          children: [CustomAppbar()],
        ),
      ),
    );
  }
}
