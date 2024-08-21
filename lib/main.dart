import 'package:eskool/Screens/admin/admindashboard/admindashboard.dart';
import 'package:eskool/Screens/admin/admindashboard/components/noticeDetailPage.dart';
import 'package:eskool/Screens/admin/admindashboard/create_notice_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/drawerController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Controller(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        title: "Eskool",
        debugShowCheckedModeBanner: false,
        home: Admindashboard(),
      ),
    );
  }
}
