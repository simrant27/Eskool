import 'package:flutter/material.dart';

AppBar customAppBar() {
  return AppBar(
    title: Text(
      "Dashboard",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    leading: Builder(
      builder: (context) => IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    ),
  );
}
