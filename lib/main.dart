import 'package:flutter/material.dart';

import 'package:eskool/Screens/admin/admindashboard/admindashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      title: "Eskool",
      debugShowCheckedModeBanner: false,
      home: Admindashboard(),
    );
  }
}
