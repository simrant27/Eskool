import 'package:flutter/material.dart';

AppBar customAppBar(title) {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 196, 232, 248),
    toolbarHeight: 80,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    leading: Builder(
      builder: (context) => IconButton(
        icon: Icon(
          Icons.menu,
          size: 30,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Properly opens the drawer
        },
      ),
    ),
  );
}
