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
import '../forBackend/parent_model.dart';
import '../forBackend/userService.dart';

class Parentsdashboard extends StatefulWidget {
  const Parentsdashboard({super.key});

  @override
  State<Parentsdashboard> createState() => _ParentsdashboardState();
}

class _ParentsdashboardState extends State<Parentsdashboard> {
  Parent? parent;
  late Future<List<NoticeInfoModel>> futureNotices;

  @override
  void initState() {
    super.initState();
    futureNotices = fetchNotices(); // Fetch notices on load
    _fetchParentData(); // Fetch parent data on load
  }

  void refreshNotices() {
    setState(() {
      futureNotices = fetchNotices(); // Refresh the notices
    });
  }

  Future<Parent> _fetchParentData() async {
    UserService userService = UserService();
    var fetchedUser = await userService.fetchUserData();
    if (fetchedUser is Parent) {
      return fetchedUser; // Return the Parent object
    } else {
      throw Exception('Failed to load Parent data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Dashboard"),
      drawer: drawerlist(context),
      body: FutureBuilder<Parent>(
        future: _fetchParentData(), // Fetch the parent data
        builder: (BuildContext context, AsyncSnapshot<Parent> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading state
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            ); // Error state
          } else if (snapshot.hasData && snapshot.data != null) {
            Parent parent = snapshot.data!; // Parent data is available
            return Column(
              children: [
                Stack(
                  children: [
                    Introduction_part(
                      context,
                      dayOfWeekShort,
                      day,
                      monthShort,
                      parent.fullName, // Use fetched parent data
                      parent.email,
                      parent.phone,
                    ),
                  ],
                ),
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
                          childAspectRatio: 1.0, // Adjust for square items
                        ),
                        itemCount: menuItems(context).length - 2,
                        itemBuilder: (context, index) {
                          final menuItem = menuItems(
                              context)[index + 1]; // Adjust for context
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
                ),
              ],
            );
          } else {
            return Center(child: Text('No parent data available'));
          }
        },
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
