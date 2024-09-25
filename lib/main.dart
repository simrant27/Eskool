import 'package:eskool/Screens/admin/admindashboard/components/dashboard_content.dart';
import 'package:eskool/Screens/admin/admindashboard/components/full_notice_list_page.dart';
import 'package:eskool/Screens/admin/admindashboard/components/notice_list.dart';
import 'package:eskool/Screens/admin/billing/billing_page.dart';

import 'package:eskool/Screens/admin/classes/student_deatail.dart';
import 'package:eskool/Screens/admin/hellopage.dart';
import 'package:eskool/loginpage/login.dart';

// import 'package:eskool/loginpage/loginPage.dart';

import 'package:flutter/material.dart';

import 'package:eskool/Screens/admin/admindashboard/admindashboard.dart';

import 'users/screen/parentsdashboard.dart';

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
        // Define initial route
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(), // Login page
          '/parents': (context) => parentsdashboard(), // Parent dashboard
          '/admin': (context) => Admindashboard(), // Admin dashboard
          // '/teacher': (context) => TeacherDashboard(),
        }
        // home: LoginPage(),
        // routes: {
        //   '/parents': (context) =>
        //       Admindashboard(), // Define your dashboard page here
        // },
        //  Admindashboard()
        // FullNoticeListPage()
        // NoticeListScreen()
        // parentsdashboard()
        //     StudentDetail(
        //   className: "2",
        // ),
        );
  }
}
