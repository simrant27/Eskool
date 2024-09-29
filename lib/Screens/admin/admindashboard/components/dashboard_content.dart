import 'dart:convert';

import 'package:eskool/Screens/admin/admindashboard/components/customAppbar.dart';
import 'package:eskool/Screens/admin/admindashboard/components/gender_pie_chart.dart';
import 'package:eskool/constants/constants.dart';
import 'package:eskool/constants/responsive.dart';
import 'package:eskool/data/noticedata.dart';
import 'package:flutter/material.dart';

import '../../../../models/notice_info_model.dart';
import '../../../../services/fetchNotice.dart';
import '../../components/notice_future_builder.dart';
import 'analyticCards.dart';
import 'calenderWidget.dart';
import 'noticewidget.dart';
import 'package:http/http.dart' as http;

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
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
                    child: Column(children: [
                      AnalyticCards(),
                      if (Responsive.isMobile(context))
                        SizedBox(
                          height: appPadding,
                        ),
                      if (Responsive.isMobile(context)) CalenderWidget(),
                      NoticeListBuilder(
                        admin: true,
                        showCreateButton: true,
                        showViewAllButton: true,
                        // onNoticeCreated: () {
                        //   // Add any actions you want to trigger when a notice is created.
                        // },
                      ),
                    ])),
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
