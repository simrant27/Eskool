import 'package:eskool/Screens/admin/admindashboard/components/calenderWidget.dart';
import 'package:eskool/Screens/admin/admindashboard/components/customAppbar.dart';
import 'package:eskool/Screens/admin/admindashboard/components/notice_form.dart';
import 'package:eskool/Screens/admin/components/custon_button.dart';
import 'package:eskool/Screens/admin/components/custom_page_layout.dart';
import 'package:eskool/constants/constants.dart';
import 'package:eskool/constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
// Import the new widget

class CreateNoticePage extends StatefulWidget {
  const CreateNoticePage({super.key});

  @override
  _CreateNoticePageState createState() => _CreateNoticePageState();
}

class _CreateNoticePageState extends State<CreateNoticePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<PlatformFile>? _mediaFiles;

  Future<void> _pickMediaFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _mediaFiles = result.files;
      });
    }
  }

  void _submitNotice() {
    final title = _titleController.text;
    final description = _descriptionController.text;

    // Handle form submission logic here
    print("Title: $title");
    print("Description: $description");
    if (_mediaFiles != null) {
      for (var file in _mediaFiles!) {
        print("Media: ${file.name}");
      }
    }
  }

  void _clearFields() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _mediaFiles = null; // Clear selected media files
    });
  }

  void _removeFile(int index) {
    setState(() {
      _mediaFiles!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NoticeForm(
      onSubmit: (title, description, files) {
        // Handle form submission logic for creating a post
        print("Create - Title: $title");
        print("Create - Description: $description");
        if (files != null) {
          for (var file in files) {
            print("Create - Media: ${file.name}");
          }
        }

        // Add your logic to save the notice data here
        // For example, you could send the data to a server or save it locally
      },
    );
  }
}
