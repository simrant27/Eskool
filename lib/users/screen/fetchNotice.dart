import 'package:eskool/Screens/admin/admindashboard/components/noticewidget.dart';
import 'package:eskool/data/noticedata.dart';
import 'package:eskool/users/component/customAppBar.dart';
import 'package:flutter/material.dart';

class FetchNotice extends StatelessWidget {
  const FetchNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Notification"),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
              NoticeWidget(noticeData: noticeData, showViewAllButton: false)),
    );
  }
}
