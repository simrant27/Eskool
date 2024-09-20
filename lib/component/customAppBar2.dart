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
  );
}
