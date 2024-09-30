import 'dart:io';
import 'package:eskool/constants/constants.dart';
import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:eskool/users/component/customAppBar2.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../component/customButtonStyle.dart';
import 'package:http/http.dart' as http;

class UploadStudyMaterialScreen extends StatefulWidget {
  @override
  _UploadStudyMaterialScreenState createState() =>
      _UploadStudyMaterialScreenState();
}

class _UploadStudyMaterialScreenState extends State<UploadStudyMaterialScreen> {
  String? fileName;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? selectedFile;
  bool isLoading = false;

  // Maximum allowed file size (5 MB)
  final int maxFileSize = 5 * 1024 * 1024; // 5 MB in bytes

  // Method to pick a file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'doc', 'docx'],
    );

    if (result != null) {
      File pickedFile = File(result.files.single.path!);
      int fileSize = pickedFile.lengthSync();

      if (fileSize <= maxFileSize) {
        // If file size is valid
        setState(() {
          selectedFile = pickedFile;
          fileName = result.files.single.name;
        });
      } else {
        // If file size exceeds the limit
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File size exceeds the limit of 5 MB')),
        );
      }
    }
  }

  Future<void> _uploadFile() async {
    // Your existing file upload logic...
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar2("Upload a Material"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
                hintText: 'Enter the title of the material',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                hintText: 'Enter a brief description',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickFile,
              icon: Icon(Icons.upload_file),
              label: Text('Choose File'),
            ),
            SizedBox(height: 16),
            if (fileName != null)
              Text(
                'Selected File: $fileName',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            else
              Text(
                'No file selected',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (fileName != null && titleController.text.isNotEmpty) {
                    _uploadFile(); // Call the upload function
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select a file and enter a title'),
                      ),
                    );
                  }
                },
                style: customButtonStyle,
                child: isLoading
                    ? CircularProgressIndicator() // Show loading indicator
                    : Text('Upload Material'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
