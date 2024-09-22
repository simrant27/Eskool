import 'package:eskool/Screens/admin/admindashboard/components/noticewidget.dart';

import 'package:eskool/Screens/admin/components/custom_page_layout.dart';
import 'package:flutter/material.dart';

import '../../../../models/notice_info_model.dart';

// Import the new NoticeCard widget

class FullNoticeListPage extends StatefulWidget {
  final List<NoticeInfoModel> noticeData;

  const FullNoticeListPage({super.key, required this.noticeData});

  @override
  State<FullNoticeListPage> createState() => _FullNoticeListPageState();
}

class _FullNoticeListPageState extends State<FullNoticeListPage> {
  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
      showSearch: true,
      hinttext: "notices",
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: NoticeWidget(
          noticeData: widget.noticeData, // Pass all notices
          showViewAllButton: false, // Do not show the View All button here
        ),
      ),
    );
  }
}
