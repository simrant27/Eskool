import 'package:eskool/Screens/admin/admindashboard/components/notice_form.dart';
import 'package:flutter/material.dart';
// Import the NoticeForm widget

class CreateNoticePage extends StatelessWidget {
  const CreateNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NoticeForm(
      onSubmit: (title, description, file) {
        print("Create - Title: $title");
        print("Create - Description: $description");
        if (file != null) {
          // Check for single file instead of a list
          print("Create - Media: ${file}");
        }

        // Add your logic to save the notice data here, such as sending the data to a server
      },
    );
  }
}
