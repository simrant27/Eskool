import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:eskool/users/component/DashboardBox.dart';
import 'package:eskool/users/component/customAppBar.dart';
import 'package:flutter/material.dart';
import '../../models/notice_info_model.dart';
import '../../services/fetchNotice.dart';
import '../component/introduction_part.dart';
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
        future: _fetchTeacherData(), // Fetch the teacher data
        builder: (BuildContext context, AsyncSnapshot<Teacher> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(), // Loading state
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            ); // Error state
          } else if (snapshot.hasData) {
            Teacher teacher = snapshot.data!; // Teacher data is available

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
                        teacher.image),
                  ],
                ),
                Expanded(
                  child: DashboardBox(context),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('No teacher data available'), // No data state
            );
          }
        },
      ),
      appBar: customAppBar("Dashboard"),
    );
  }
}
