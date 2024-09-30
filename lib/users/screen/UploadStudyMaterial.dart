import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:eskool/users/component/customAppBar2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/constants.dart';
import '../component/customButtonStyle.dart';

class UploadStudyMaterialScreen extends StatefulWidget {
  @override
  _UploadStudyMaterialScreenState createState() =>
      _UploadStudyMaterialScreenState();
}

class _UploadStudyMaterialScreenState extends State<UploadStudyMaterialScreen> {
  String? fileName;
  String? filePath;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedFile;

  Future<void> _pickFile() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        _selectedFile = File(file.path);
      });
    }
  }

  Future<void> _uploadMaterial() async {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select a file to upload.")));
      return;
    }

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$url/api/materials'), // Replace with your API URL
    );

    request.files.add(await http.MultipartFile.fromPath(
      'file',
      _selectedFile!.path,
    ));
    request.fields['title'] = _titleController.text;
    request.fields['description'] = _descriptionController.text;

    try {
      final response = await request.send();
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Material uploaded successfully!")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to upload material.")));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("An error occurred: $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Input
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  hintText: 'Enter the title of the material',
                ),
              ),
              SizedBox(height: 16),

              // Description Input
              TextField(
                controller: _descriptionController,
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
                    if (fileName != null && _titleController.text.isNotEmpty) {
                      // Implement upload functionality here
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Upload Successful'),
                          content: Text('Your material has been uploaded.'),
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
                    } else {
                      // Show error if no file or title
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Please select a file and enter a title'),
                        ),
                      );
                    }
                  },
                  style: customButtonStyle,
                  child: Text('Upload Material'),
                ),
              )
            ],
          ),
        ),
        appBar: customAppBar2("Upload a Material"));
  }
}
