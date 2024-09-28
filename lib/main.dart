import 'package:eskool/Create%20account/screens/admin_dashboard.dart';
import 'package:eskool/Screens/admin/admindashboard/components/dashboard_content.dart';
import 'package:eskool/Screens/admin/admindashboard/components/full_notice_list_page.dart';
import 'package:eskool/Screens/admin/admindashboard/components/notice_list.dart';
import 'package:eskool/Screens/admin/billing/billing_page.dart';

import 'package:eskool/Screens/admin/classes/student_deatail.dart';
import 'package:eskool/Screens/admin/hellopage.dart';
import 'package:eskool/Screens/admin/parents/parent_list_screen.dart';
import 'package:eskool/Screens/admin/teacher/teacher_list_screen.dart';
import 'package:eskool/data/teacher_data.dart';

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
        home: ParentListScreen()

        // parentsdashboard()
        //     StudentDetail(
        //   className: "Class 1",
        // ),
        );
  }
}
