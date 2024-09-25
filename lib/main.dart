import 'package:flutter/material.dart';

import 'package:eskool/Screens/admin/admindashboard/components/dashboard_content.dart';
import 'package:eskool/Screens/admin/billing/billing_page.dart';

import 'package:eskool/Screens/admin/classes/student_deatail.dart';

import 'package:flutter/material.dart';

import 'package:eskool/Screens/admin/admindashboard/admindashboard.dart';

import 'users/screen/parentsdashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        title: "Eskool",
        debugShowCheckedModeBanner: false,
        home: Admindashboard()

        // FullNoticeListPage()
        // NoticeListScreen()
        // Parentsdashboard()
        //     StudentDetail(
        //   className: "2",
        // ),
        );
  }
}
