import 'dart:io';
import 'package:eskool/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadMaterialScreen extends StatefulWidget {
  @override
  _UploadMaterialScreenState createState() => _UploadMaterialScreenState();
}

class _UploadMaterialScreenState extends State<UploadMaterialScreen> {
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
      Uri.parse(
          '$url/api/materials'), // Replace with your API URL
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Material"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text("Select File"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadMaterial,
              child: Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
