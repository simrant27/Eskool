import 'package:eskool/users/component/customAppBar2.dart';
import 'package:eskool/users/component/customBottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eskool/models/notice_info_model.dart';
import 'package:eskool/Screens/admin/admindashboard/components/noticeDetailPage.dart';

class NoticeList extends StatelessWidget {
  final List<NoticeInfoModel> noticeData;
  final bool? admin;

  const NoticeList({super.key, required this.noticeData, this.admin = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: noticeData.asMap().entries.map((entry) {
        final index = entry.key;
        final notice = entry.value;

        return Column(
          children: [
            InkWell(
              onTap: () {
                print("Tapped on notice: ${notice.title}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => admin!
                        ? NoticeDetailsPage(
                            showCustomLayout: false,
                            notice: notice,
                          )
                        : Scaffold(
                            appBar: customAppBar2(notice.title),
                            body: NoticeDetailPageBody(
                                notice: notice, showEditAndDelete: false),
                            bottomNavigationBar: CustomBottomAppBar(),
                          ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notice.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            notice.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            DateFormat('dd MMM yyyy').format(notice.createdAt!),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            if (index < noticeData.length - 1) Divider(),
          ],
        );
      }).toList(),
    );
  }
}
