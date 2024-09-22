import 'package:eskool/Screens/admin/admindashboard/edit_notice.dart';
import 'package:eskool/Screens/admin/components/custon_button.dart';
import 'package:eskool/Screens/admin/components/custom_page_layout.dart';

import 'package:eskool/models/notice_info_model.dart';
import 'package:flutter/material.dart';

import '../../../../utility/delete_dialog_utils.dart';

class NoticeDetailsPage extends StatelessWidget {
  final NoticeInfoModel notice;

  const NoticeDetailsPage({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
      child: Padding(
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
                  CustomButton(
                    icon: Icons.edit,
                    label: "Edit",
                    color: const Color.fromARGB(255, 82, 168, 239),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => EditNoticePage(
                      //       initialTitle: notice.title,
                      //       initialDescription: notice.description,
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                  SizedBox(width: 10),
                  CustomButton(
                      label: "Delete",
                      color: Colors.red,
                      onPressed: () {
                        showDeleteConfirmationDialog(context, () {
                          // Handle delete logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Notice deleted successfully')),
                          );
                        });
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
