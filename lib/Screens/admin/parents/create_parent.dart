import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Import the file picker package
import 'package:http/http.dart' as http; // For making HTTP requests
import 'dart:convert';

import '../../../models/parentModel.dart';
import '../../../services/parentService.dart';
import '../teacher1/component.dart/form_input_field.dart'; // For JSON encoding

class ParentFormPage extends StatefulWidget {
  @override
  _ParentFormPageState createState() => _ParentFormPageState();
}

class _ParentFormPageState extends State<ParentFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  PlatformFile? _image; // To hold the selected image file

  Future<void> _pickImage() async {
    // Use the file picker to select an image file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Restricting to images
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _image = result.files.first; // Get the first selected file
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Create the Parent object
      Parent parent = Parent(
        fullName: _fullNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        username: _usernameController.text,
        password: _passwordController.text,
        // image will be sent separately during HTTP request
      );

      // Call your service to create the parent with the selected image
      try {
        var response = await ParentService.createParent(parent, _image);

        // Successfully created parent
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Parent created successfully!')),
        );
        // Optionally clear the form or navigate to another page
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _pickMediaFiles() async {
    Future<void> _pickImage() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'], // Limit file types
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _image = result.files.first;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Parent'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormInputField(
                label: 'Full Name',
                controller: _fullNameController,
              ),
              FormInputField(
                label: 'Email',
                controller: _emailController,
              ),
              FormInputField(
                label: 'Phone',
                controller: _phoneController,
              ),
              FormInputField(
                label: 'Address',
                controller: _addressController,
              ),
              FormInputField(
                label: 'Username',
                controller: _usernameController,
              ),
              FormInputField(
                label: 'Password',
                controller: _passwordController,
                isPassword: true,
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _image != null
                        ? 'Image Selected: ${_image!.name}'
                        : 'Select Image',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
