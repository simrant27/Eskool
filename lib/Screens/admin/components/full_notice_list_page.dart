import 'package:eskool/Screens/admin/components/noticewidget.dart';
import 'package:eskool/Screens/admin/components/responsive_drawer_layout.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../models/notice_info_model.dart';
import 'customAppbar.dart';
// Import the new NoticeCard widget

class FullNoticeListPage extends StatelessWidget {
  final List<NoticeInfoModel> noticeData;

  const FullNoticeListPage({super.key, required this.noticeData});

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
        content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding),
        child: Column(
          children: [
            CustomAppbar(
              hinttext: "notices",
            ),
            SizedBox(
              height: appPadding,
            ),
            NoticeWidget(
              noticeData: noticeData, // Pass all notices
              showViewAllButton: false, // Do not show the View All button here
            ),
          ],
        ),
      ),
    ));
  }
}
