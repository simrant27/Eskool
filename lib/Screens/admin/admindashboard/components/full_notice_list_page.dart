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
  List<NoticeInfoModel> filteredNotices = [];

  // Store the search query
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Initially, all notices will be shown
    filteredNotices = widget.noticeData;
  }

  // This method filters the notices based on the search query
  void _filterNotices(String query) {
    setState(() {
      _searchQuery = query;

      if (query.isEmpty) {
        // If the search query is empty, show all notices
        filteredNotices = widget.noticeData;
      } else {
        // Filter the notices by title or description
        filteredNotices = widget.noticeData.where((notice) {
          final titleLower = notice.title.toLowerCase();
          final descriptionLower = notice.description.toLowerCase();
          final searchLower = query.toLowerCase();

          return titleLower.contains(searchLower) ||
              descriptionLower.contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
      showSearch: true,
      hinttext: "notices",
      onChanged: _filterNotices,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: NoticeWidget(
          noticeData: filteredNotices, // Pass all notices
          showViewAllButton: false, // Do not show the View All button here
        ),
      ),
    );
  }
}
