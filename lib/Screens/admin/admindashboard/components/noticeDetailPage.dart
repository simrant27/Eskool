import 'package:eskool/constants/constants.dart';
import 'package:eskool/models/notice_info_model.dart';
import 'package:flutter/material.dart';
import 'package:eskool/Screens/admin/admindashboard/components/customAppbar.dart';
import 'package:eskool/Screens/admin/admindashboard/components/responsive_drawer_layout.dart';

class NoticeDetailsPage extends StatelessWidget {
  final NoticeInfoModel notice;
  const NoticeDetailsPage({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
      content: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                hinttext: "Notices",
                showSearch: false,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  margin: EdgeInsets.all(32),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Notice Title
                      Text(
                        notice.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),

                      // Notice Description
                      Text(
                        notice.description,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      SizedBox(height: 24),
                      if (notice.files != null && notice.files!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: notice.files!.length,
                              itemBuilder: (context, index) {
                                final media = notice.files![index];
                                return ListTile(
                                  leading: Icon(media.endsWith('.pdf')
                                      ? Icons.picture_as_pdf
                                      : Icons.image),
                                  title: Text(media),
                                  onTap: () {
                                    // Handle media file opening logic here
                                  },
                                );
                              },
                            ),
                          ],
                        ),

                      // Edit and Delete Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Navigate to the Edit page
                            },
                            icon: Icon(Icons.edit),
                            label: Text(
                              "Edit",
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 82, 168, 239),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Handle delete logic
                            },
                            icon: Icon(Icons.delete),
                            label: Text(
                              "Delete",
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
