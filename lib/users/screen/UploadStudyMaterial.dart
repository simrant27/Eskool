import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:eskool/users/component/customAppBar2.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
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
  PlatformFile? _selectedFile;

  // Future<void> _pickFile() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
  //   if (file != null) {
  //     setState(() {
  //       _selectedFile = File(file.path);
  //     });
  //   }
  // }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf', 'jpeg'],
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
      });
    }
  }

  Future<void> _uploadMaterial(
      String title, String description, PlatformFile? file) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/api/materials'), // Replace with your API URL
      );

      request.fields['title'] = title;
      request.fields['description'] = description;

      if (_selectedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please select a file to upload.")));
        return;
      }

      if (file != null) {
        // Determine content type based on file extension
        String mimeType = '';
        if (file.extension == 'png') {
          mimeType = 'image/png';
        } else if (file.extension == 'jpg' || file.extension == 'jpeg') {
          mimeType = 'image/jpeg';
        } else if (file.extension == 'pdf') {
          mimeType = 'application/pdf';
        }
        request.files.add(await http.MultipartFile.fromBytes(
          'file',
          file.bytes!,
          filename: file.name,
          contentType: MediaType.parse(mimeType),
        ));

        final response = await request.send();
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Material uploaded successfully!")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to upload material.")));
        }
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
              if (_selectedFile != null) ...[
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(_selectedFile!.extension == 'pdf'
                      ? Icons.picture_as_pdf
                      : Icons.image),
                  title: Text(_selectedFile!.name),
                  trailing: IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _selectedFile = null; // Remove the file
                      });
                    },
                  ),
                ),
              ],
              if (_selectedFile == null)
                Text(
                  'No file selected',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              Spacer(),

              // Submit Button

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedFile != null && _titleController.text.isNotEmpty) {
                      _uploadMaterial(
                          _titleController.text,
                          _descriptionController.text,
                          _selectedFile != null ? _selectedFile : null);
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
