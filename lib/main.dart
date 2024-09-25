import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eskool/Screens/admin/admindashboard/admindashboard.dart';
import 'package:eskool/Screens/admin/billing/billing_page.dart';
// import 'package:eskool/Screens/admin/classes/student_detail.dart';
import 'package:eskool/Screens/admin/hellopage.dart';
import 'package:eskool/loginpage/login.dart';
import 'users/screen/parentsdashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String userRole = prefs.getString('role') ?? 'parent'; // Default to 'parent'

  runApp(MyApp(
      initialRoute: isLoggedIn
          ? (userRole == 'admin' ? '/admin' : '/parents')
          : '/login'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      title: "Eskool",
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => LoginPage(),
        '/parent-dashboard': (context) => parentsdashboard(),
        '/admin-dashboard': (context) => Admindashboard(),
        // Add other routes as necessary
      },
    );
  }
}
