import 'package:eskool/Screens/admin/admindashboard/create_notice_page.dart';
import 'package:eskool/Screens/admin/components/custon_button.dart';
import 'package:eskool/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:eskool/models/notice_info_model.dart';
import 'full_notice_list_page.dart';
import 'notice_list.dart'; // Import the new NoticeList widget

class NoticeWidget extends StatelessWidget {
  final List<NoticeInfoModel> noticeData;
  final bool showViewAllButton;

  const NoticeWidget(
      {super.key, required this.noticeData, required this.showViewAllButton});

  @override
  Widget build(BuildContext context) {
    // Get only the latest 4 notices
    final noticesToShow =
        showViewAllButton ? noticeData.take(4).toList() : noticeData;

    return Card(
      color: secondaryColor,
      margin: EdgeInsets.symmetric(vertical: appPadding),
      child: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notices",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                CustomButton(
                  label: "Create Notice",
                  color: Colors.blue.shade100,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNoticePage()));
                  },
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Divider(),
            NoticeList(noticeData: noticesToShow), // Use the new widget here
            if (showViewAllButton && noticeData.length > 4)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      // Navigate to the full notice list page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullNoticeListPage(
                            noticeData: noticeData,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
