import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'components/notice_form.dart';

class EditNoticePage extends StatelessWidget {
  final String initialTitle;
  final String initialDescription;
  final List<PlatformFile>? initialFiles;

  const EditNoticePage({
    Key? key,
    required this.initialTitle,
    required this.initialDescription,
    this.initialFiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoticeForm(
      initialTitle: initialTitle,
      initialDescription: initialDescription,
      initialFiles: initialFiles,
      onSubmit: (title, description, files) {
        // Handle the updated notice data
        print("Edit - Title: $title");
        print("Edit - Description: $description");
        if (files != null) {
          for (var file in files) {
            print("Edit - Media: ${file.name}");
          }
        }

        // Navigate back to previous page
        Navigator.pop(context);
      },
    );
  }
}
