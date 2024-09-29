import 'package:flutter/material.dart';
import 'screens/admin_dashboard.dart';


void main() => runApp(SchoolManagementApp());

class SchoolManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: parentsboard(),
      theme: ThemeData(
        fontFamily: 'Raleway',
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
    );
  }
}
