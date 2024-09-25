// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:eskool/Screens/admin/admindashboard/components/customAppbar.dart';
import 'package:eskool/Screens/admin/admindashboard/components/gender_pie_chart.dart';
import 'package:eskool/constants/constants.dart';
import 'package:eskool/constants/responsive.dart';
import 'package:eskool/data/noticedata.dart';
import 'package:flutter/material.dart';

import 'analyticCards.dart';
import 'calenderWidget.dart';
import 'noticewidget.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  Future<State<DashboardContent>> createState() async =>
      _DashboardContentState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _DashboardContentState extends State<DashboardContent> {
  late Future<List<NoticeInfoModel>> futureNotices;
  @override
  void initState() {
    super.initState();
    futureNotices = fetchNotices(); // Call the fetch method
  }

  Future<List<NoticeInfoModel>> fetchNotices() async {
    final response =
        await http.get(Uri.parse('http://192.168.18.56:3000/api/notices'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      List<dynamic> jsonResponse = json.decode(response.body);
      List<NoticeInfoModel> notices = jsonResponse
          .map((notice) => NoticeInfoModel.fromJson(notice))
          .toList();

      // Update the global noticeData list
      noticeData.clear(); // Clear previous data if needed
      noticeData.addAll(notices); // Add fetched notices to the global list

      return notices; // Return the fetched notices
    } else {
      throw Exception('Failed to load notices');
    }
  }

  void refreshNotices() {
    setState(() {
      futureNotices = fetchNotices(); // Refresh the notices
    });
  }

  @override
  Widget build(BuildContext context) {
    final topNotices = noticeData.take(4).toList();
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding),
        child: Column(
          children: [
            CustomAppbar(
              hinttext: "students",
              // onChanged: ,
            ),
            SizedBox(
              height: appPadding,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        AnalyticCards(),
                        if (Responsive.isMobile(context))
                          SizedBox(
                            height: appPadding,
                          ),
                        if (Responsive.isMobile(context)) CalenderWidget(),
                        NoticeWidget(
                          noticeData: noticeData,
                          showViewAllButton: true,
                        ),
                      ],
                    )),
                if (!Responsive.isMobile(context))
                  SizedBox(
                    width: appPadding,
                  ),
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        CalenderWidget(),
                        SizedBox(height: appPadding),
                        GenderPieChart(
                          boysCount: 500,
                          girlsCount: 600,
                          othersCount: 2,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
