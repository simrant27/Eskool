import 'package:eskool/users/component/customAppBar.dart';
import 'package:eskool/users/component/customAppBar2.dart';
import 'package:eskool/users/component/customBottomAppBar.dart';
import 'package:eskool/users/component/drawerlist.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final dynamic body;
  final dynamic appBar;
  final dynamic bottomApp;

  const CustomScaffold({required this.body, required this.appBar, 
  this.bottomApp=true,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
     bottomNavigationBar:bottomApp? CustomBottomAppBar():null,
    );
  }
}
