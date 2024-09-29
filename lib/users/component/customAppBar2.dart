// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

AppBar customAppBar2(title) {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 196, 232, 248),
    toolbarHeight: 80,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    ),
    leading: Builder(
      builder: (context) => IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: 30,
          // color: Color(value),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}
