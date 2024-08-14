import 'package:eskool/Screens/admin/create_notice_page.dart';
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNoticePage()));
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                          color: Colors.blue[100], // Button color
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: Text(
                        "Create Notice",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
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
                          builder: (context) =>
                              FullNoticeListPage(noticeData: noticeData),
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
