import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:flutter/material.dart';
import '../../models/notice_info_model.dart';
import '../../services/fetchNotice.dart';

import '../component/customBox.dart';

import '../component/introduction_part.dart';
import '../data/colorCombination.dart';
import '../data/date.dart';
import '../data/menuItems.dart';
import '../forBackend/teacher_model.dart';
import '../forBackend/userService.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  Teacher? teacher;

  late Future<List<NoticeInfoModel>> futureNotices;
  late Future<List<MenuItem>> futureMenuItems;

  @override
  void initState() {
    super.initState();
    futureNotices = fetchNotices(); // Fetch notices when initializing
    futureMenuItems = menuItems(context); // Fetch menu items when initializing
    _fetchTeacherData(); // Fetch teacher data
  }

  void refreshNotices() {
    setState(() {
      futureNotices = fetchNotices(); // Refresh the notice list
    });
  }

  // Asynchronously fetch teacher data from user service
  Future<Teacher> _fetchTeacherData() async {
    UserService userService = UserService();
    var fetchedUser = await userService.fetchUserData();
    if (fetchedUser is Teacher) {
      return fetchedUser; // Return Teacher object
    } else {
      throw Exception('Failed to load teacher data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: FutureBuilder<Teacher>(
          future: _fetchTeacherData(), // Fetch the teacher data asynchronously
          builder: (BuildContext context, AsyncSnapshot<Teacher> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator()); // Loading state
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              ); // Error state
            } else if (snapshot.hasData && snapshot.data != null) {
              Teacher teacher = snapshot.data!;
              return FutureBuilder<List<MenuItem>>(
                future: futureMenuItems, // Fetch menu items asynchronously
                builder: (context, menuSnapshot) {
                  if (menuSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Loading menu items
                  } else if (menuSnapshot.hasError) {
                    return Center(
                      child: Text('Error: ${menuSnapshot.error}'),
                    ); // Error loading menu items
                  } else if (menuSnapshot.hasData &&
                      menuSnapshot.data != null) {
                    List<MenuItem> teacherlistMenu =
                        menuSnapshot.data!.where((item) {
                      return item.title == 'Chat' ||
                          item.title == 'Notification' ||
                          item.title == 'Assignment' ||
                          item.title == 'Profile' ||
                          item.title == 'Materials';
                    }).toList();

                    return Column(
                      children: [
                        Stack(
                          children: [
                            Introduction_part(
                              context,
                              dayOfWeekShort,
                              day,
                              monthShort,
                              teacher.fullName, // Use fetched teacher data
                              teacher.email,
                              teacher.phone,
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
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Two items per row
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 30,
                                  childAspectRatio: 1.0, // Square items
                                ),
                                itemCount:
                                    teacherlistMenu.length, // Number of items
                                itemBuilder: (context, index) {
                                  final menuItem = teacherlistMenu[index];
                                  return GestureDetector(
                                    onTap: menuItem.onTap, // Action on tap
                                    child: customBox(
                                      menuItem, // Display menu item
                                      boxGradients[index %
                                          boxGradients
                                              .length], // Gradient background
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
                    return Center(
                        child: Text(
                            'No menu data available')); // No menu data state
                  }
                },
              );
            } else {
              return Center(
                  child: Text('No teacher data available')); // No data state
            }
          },
        ),
        appbartitle: "Dashboard",
        showArrow: false);
  }
}
