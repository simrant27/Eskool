import 'package:flutter/material.dart';
import '../../models/notice_info_model.dart';
import '../../services/fetchNotice.dart';
import '../component/Drawerlist.dart';
import '../component/customAppBar.dart';
import '../component/customBottomAppBar.dart';
import '../component/customBox.dart';
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
  late Future<List<NoticeInfoModel>> futureNotices;

  @override
  void initState() {
    super.initState();
    _fetchTeacherData();
    futureNotices = fetchNotices(); // Call the fetch method
  }

  void refreshNotices() {
    setState(() {
      futureNotices = fetchNotices(); // Refresh the notices
    });
  }

  Future<Teacher> _fetchTeacherData() async {
    UserService userService = UserService();
    var fetchedUser = await userService.fetchUserData();
    if (fetchedUser is Teacher) {
      return fetchedUser; // Return the Parent object
    } else {
      throw Exception('Failed to load teacher data');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<MenuItem> teacherlistMenu = menuItems(context).where((item) {
      return item.title == 'Chat' ||
          item.title == 'Notification' ||
          item.title == 'Assignment' ||
          item.title == 'Profile' ||
          item.title == 'Materials';
    }).toList();

    return Scaffold(
      appBar: customAppBar("Dashboard"),
      drawer: drawerlist(context),
      body: FutureBuilder<Teacher>(
        future: _fetchTeacherData(), // Fetch the teacher data
        builder: (BuildContext context, AsyncSnapshot<Teacher> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading state
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            ); // Error state
          } else if (snapshot.hasData && snapshot.data != null) {
            Teacher teacher = snapshot.data!; // Parent data is available
            return Column(
              children: [
                Stack(
                  children: [
                    Introduction_part(
                      context,
                      dayOfWeekShort,
                      day,
                      monthShort,
                      teacher.fullName, // Use fetched parent data
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 30,
                          childAspectRatio: 1.0, // Adjusted for square items
                        ),
                        itemCount: teacherlistMenu.length,
                        itemBuilder: (context, index) {
                          final menuItem = teacherlistMenu[index];
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
