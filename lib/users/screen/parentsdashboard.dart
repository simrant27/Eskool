// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:eskool/models/notice_info_model.dart';
import 'package:eskool/services/fetchNotice.dart';
import 'package:flutter/material.dart';
import '../component/Drawerlist.dart';
import '../component/customAppBar.dart';
import '../component/customBottomAppBar.dart';
import '../component/customBox.dart';
import '../component/introduction_part.dart';
import '../data/colorCombination.dart';
import '../data/date.dart';
import '../data/menuItems.dart';

class Parentsdashboard extends StatefulWidget {
  const Parentsdashboard({super.key});

  @override
  State<Parentsdashboard> createState() => _ParentsdashboardState();
}

class _ParentsdashboardState extends State<Parentsdashboard> {
  late Future<List<NoticeInfoModel>> futureNotices;

  @override
  void initState() {
    super.initState();
    futureNotices = fetchNotices(); // Call the fetch method
  }

  void refreshNotices() {
    setState(() {
      futureNotices = fetchNotices(); // Refresh the notices
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Dashboard"),
      drawer: drawerlist(context),
      body: Column(
        children: [
          Introduction_Part(context, dayOfWeekShort, day, monthShort),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 30,
                    childAspectRatio: 1.0, // Adjusted for square items
                  ),
                  itemCount: menuItems(context).length - 2,
                  itemBuilder: (context, index) {
                    final menuItem =
                        menuItems(context)[index + 1]; // Adjust for context
                    return GestureDetector(
                      onTap: menuItem.onTap,
                      child: customBox(
                        menuItem,
                        boxGradients[index % boxGradients.length],
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
