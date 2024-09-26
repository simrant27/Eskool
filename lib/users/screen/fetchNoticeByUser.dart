import 'package:eskool/Screens/admin/admindashboard/components/noticewidget.dart';
import 'package:eskool/Screens/admin/components/notice_future_builder.dart';
import 'package:eskool/data/noticedata.dart';
import 'package:eskool/users/component/customAppBar.dart';
import 'package:eskool/users/component/customAppBar2.dart';
import 'package:eskool/users/component/customBottomAppBar.dart';
import 'package:flutter/material.dart';

class FetchNoticeByUser extends StatefulWidget {
  const FetchNoticeByUser({super.key});

  @override
  State<FetchNoticeByUser> createState() => _FetchNoticeByUserState();
}

class _FetchNoticeByUserState extends State<FetchNoticeByUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar2("Notices"),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: NoticeListBuilder(
          showCreateButton: false,
          showViewAllButton: false,
          admin: false,
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
