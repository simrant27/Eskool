import 'package:eskool/Screens/admin/admindashboard/edit_notice.dart';
import 'package:eskool/Screens/admin/admindashboard/viewNorticefile.dart';
import 'package:eskool/Screens/admin/components/custon_button.dart';
import 'package:eskool/Screens/admin/components/custom_page_layout.dart';

import 'package:eskool/models/notice_info_model.dart';
import 'package:eskool/services/FileLauncher.dart';
import 'package:flutter/material.dart';

import '../../../../utility/delete_dialog_utils.dart';

class NoticeDetailsPage extends StatelessWidget {
  final NoticeInfoModel notice;
  final bool? showEditAndDelete;
  final bool? showAppBar;
  final bool? showCustomLayout;

  const NoticeDetailsPage(
      {super.key,
      required this.notice,
      this.showAppBar = true,
      this.showEditAndDelete = true,
      this.showCustomLayout});

  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
      showCustomLayout: showCustomLayout,
      showBackButton: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NoticeDetailPageBody(
            notice: notice, showEditAndDelete: showEditAndDelete),
      ),
    );
  }
}

class NoticeDetailPageBody extends StatelessWidget {
  const NoticeDetailPageBody({
    super.key,
    required this.notice,
    required this.showEditAndDelete,
  });

  final NoticeInfoModel notice;
  final bool? showEditAndDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
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

          // Text(notice.files!),
          if (notice.file != null && notice.file!.isNotEmpty)
            ListTile(
              leading: Icon(notice.file!.endsWith('.pdf')
                  ? Icons.picture_as_pdf
                  : Icons.file_present),
              title: Text(notice.file!.split('\\').last), // Get the file name
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewNoticeFile(
                      title: notice.title,
                      description: notice.description,
                      fileUrl: notice.file,
                    ),
                  ),
                );
              },
            ),

          // Edit and Delete Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (showEditAndDelete!)
                // CustomButton(
                //   icon: Icons.edit,
                //   label: "Edit",
                //   color: const Color.fromARGB(255, 82, 168, 239),
                //   onPressed: () {
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) => EditNoticePage(
                //     //       initialTitle: notice.title,
                //     //       initialDescription: notice.description,
                //     //     ),
                //     //   ),
                //     // );
                //   },
                // ),
                SizedBox(width: 10),
              if (showEditAndDelete!)
                CustomButton(
                  label: "Delete",
                  color: Colors.red,
                  onPressed: () {
                    showDeleteConfirmationDialog(
                      context,
                      notice.id, // Pass the notice ID to delete
                      () {
                        Navigator.pop(context);
                        // Callback to handle UI update after deletion
                        // You can refresh the notice list or navigate accordingly
                      },
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
