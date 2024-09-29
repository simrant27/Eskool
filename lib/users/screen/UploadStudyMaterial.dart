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
  String? filePath;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? selectedFile; // This will hold the selected file

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'], // Define file types
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
        fileName = result.files.single.name; // Update fileName to display
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> _uploadFile() async {
    if (selectedFile != null) {
      String apiUrl = '$url/api/upload'; // Your backend API URL

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.fields['title'] = titleController.text; // Add title to request
      request.fields['description'] =
          descriptionController.text; // Add description to request
      request.files
          .add(await http.MultipartFile.fromPath('file', selectedFile!.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        print('File uploaded successfully');
        // Show success dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Upload Successful'),
            content: Text('Your material has been uploaded.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Clear the fields after successful upload
                  titleController.clear();
                  descriptionController.clear();
                  setState(() {
                    selectedFile = null; // Reset selected file
                    fileName = null; // Reset file name
                  });
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('Failed to upload file');
        // Show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Upload Failed'),
            content: Text('There was an error uploading your material.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // Show error if no file is selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a file to upload'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar2("Upload a Material"), // Updated appBar call
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Input
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
                hintText: 'Enter the title of the material',
              ),
            ),
            SizedBox(height: 16),

            // Description Input
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

            // Upload Button
            ElevatedButton.icon(
              onPressed: _pickFile,
              icon: Icon(Icons.upload_file),
              label: Text('Choose File'),
            ),
            SizedBox(height: 16),

            // Display selected file
            if (fileName != null)
              Text(
                'Selected File: $fileName',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            if (fileName == null)
              Text(
                'No file selected',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            Spacer(),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (fileName != null && titleController.text.isNotEmpty) {
                    _uploadFile(); // Call the upload function
                  } else {
                    // Show error if no file or title
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select a file and enter a title'),
                      ),
                    );
                  }
                },
                style: customButtonStyle,
                child: Text('Upload Material'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
