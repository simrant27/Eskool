import 'package:eskool/Screens/admin/admindashboard.dart';
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
        home: Admindashboard(), // Ensure this is wrapped in MultiProvider
      ),
    );
  }
}
