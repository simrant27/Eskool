import 'package:eskool/chat/Screens/login_screnn.dart';
import 'package:eskool/users/screen/teacherScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eskool/Screens/admin/admindashboard/admindashboard.dart';
import 'package:eskool/loginpage/login.dart';
import 'users/data/userImage.dart';
import 'users/screen/parentsdashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserImageLoader.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Check if the user is logged in and fetch their role
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String userRole = prefs.getString('role') ?? 'parent'; // Default to 'parent'

  // Determine the initial route based on login status and role
  String initialRoute = getInitialRoute(isLoggedIn, userRole);

  runApp(MyApp(initialRoute: initialRoute));
}

String getInitialRoute(bool isLoggedIn, String userRole) {
  if (isLoggedIn) {
    switch (userRole) {
      case 'admin':
        return '/admin-dashboard';
      case 'parent':
        return '/parent-dashboard';
      case 'teacher':
        return '/teacher-dashboard';
      default:
        return '/login'; // Fallback if role is not recognized
    }
  } else {
    return '/login';
  }
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Eskool",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      // initialRoute: initialRoute,
      routes: {
        // '/': (context) => LoginPage(),
        '/': (context) => LoginScreen(),

        '/login': (context) => LoginPage(),
        '/parent-dashboard': (context) => Parentsdashboard(),
        '/admin-dashboard': (context) => Admindashboard(),
        '/teacher-dashboard': (context) => TeacherDashboard(),
        // Add more routes here if needed
      },
    );
  }
}
