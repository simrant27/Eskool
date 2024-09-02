import 'package:flutter/material.dart';

class Customappbar extends StatelessWidget {
  const Customappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

AppBar customAppBar(title, size) {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 196, 232, 248),
    toolbarHeight: 80,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    ),
    leading: Builder(
      builder: (context) => IconButton(
        icon: Icon(
          Icons.menu,
          size: 30,
          // color: Color(value),
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    ),
  );
}
