import 'package:flutter/material.dart';
import 'package:eskool/models/notice_info_model.dart';
import 'package:eskool/services/fetch_notice.dart';
import '../admindashboard/components/noticewidget.dart';

class NoticeListBuilder extends StatefulWidget {
  final bool showCreateButton;
  final bool showViewAllButton;
  final Function? onNoticeCreated;
  final bool? admin;

  const NoticeListBuilder({
    Key? key,
    this.showCreateButton = true,
    this.showViewAllButton = true,
    this.onNoticeCreated,
    this.admin,
  }) : super(key: key);

  @override
  _NoticeListBuilderState createState() => _NoticeListBuilderState();
}

class _NoticeListBuilderState extends State<NoticeListBuilder> {
  late Future<List<NoticeInfoModel>> futureNotices;

  @override
  void initState() {
    super.initState();
    futureNotices = fetchNotices();
  }

  void refreshNotices() {
    setState(() {
      futureNotices = fetchNotices(); // Refresh notices when needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NoticeInfoModel>>(
      future: futureNotices,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No notices found'));
        }
        final notice = snapshot.data!;

        return NoticeWidget(
          admin: widget.admin,
          showCreateButton: widget.showCreateButton,
          noticeData: notice,
          showViewAllButton: widget.showViewAllButton,
          onNoticeCreated:
              refreshNotices, // Callback for when a notice is created
        );
      },
    );
  }
}
