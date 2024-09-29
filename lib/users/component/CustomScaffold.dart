import 'package:eskool/users/component/customAppBar.dart';
import 'package:eskool/users/component/customAppBar2.dart';
import 'package:eskool/users/component/customBottomAppBar.dart';
import 'package:eskool/users/component/drawerlist.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final dynamic body;
  final bool showArrow;
  final String appbartitle;

  const CustomScaffold(
      {required this.body,
      required this.appbartitle,
      required this.showArrow,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          (showArrow) ? customAppBar2(appbartitle) : customAppBar(appbartitle),
      drawer: CustomDrawerForUser(context),
      body: body,
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
