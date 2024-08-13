import 'package:eskool/Screens/admin/components/noticeDetailPage.dart';
import 'package:eskool/Screens/admin/create_notice_page.dart';
import 'package:eskool/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:eskool/models/notice_info_model.dart';
import 'package:intl/intl.dart';

class NoticeWidget extends StatelessWidget {
  final List<NoticeInfoModel> noticeData;

  const NoticeWidget({super.key, required this.noticeData});

  @override
  Widget build(BuildContext context) {
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
            Column(
              children: noticeData.asMap().entries.map((entry) {
                final index = entry.key;
                final notice = entry.value;

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NoticeDetailsPage(notice: notice),
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
                                    DateFormat('hh:mm a').format(notice.date),
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
            )
          ],
        ),
      ),
    );
  }
}
