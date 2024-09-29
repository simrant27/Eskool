import 'package:eskool/users/component/customAppBar.dart';
import 'package:eskool/users/component/customAppBar2.dart';
import 'package:eskool/users/component/customBottomAppBar.dart';
import 'package:eskool/users/component/drawerlist.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final dynamic body;
  final dynamic appBar;

  const CustomScaffold({required this.body, required this.appBar, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: CustomDrawerForUser(context),
      body: body,
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
