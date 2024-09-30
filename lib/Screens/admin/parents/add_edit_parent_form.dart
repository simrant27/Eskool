import 'dart:math';

import 'package:eskool/Screens/admin/components/custom_page_layout.dart';
import 'package:eskool/models/ParentMode.dart';
import 'package:eskool/services/parentService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import '../../../models/parentModel.dart';
import 'package:file_picker/file_picker.dart';

import '../components/custon_button.dart';

class AddEditParentScreen extends StatefulWidget {
  final Parent? parent;
  final Function(Parent)? onAddParent;
  final Function(Parent)? onEditParent;
  final PlatformFile? image;
  const AddEditParentScreen({
    Key? key,
    this.parent,
    this.onAddParent,
    this.onEditParent,
    this.image,
  }) : super(key: key);

  @override
  _AddEditParentScreenState createState() => _AddEditParentScreenState();
}

class _AddEditParentScreenState extends State<AddEditParentScreen> {
  final ParentService parentService = ParentService();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _addressController = TextEditingController();
  late TextEditingController _usernameController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  PlatformFile? _image;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.parent?.fullName);
    _emailController = TextEditingController(text: widget.parent?.email);
    _phoneController = TextEditingController(text: widget.parent?.phone);
    _usernameController = TextEditingController(text: widget.parent?.username);
    _passwordController = TextEditingController(text: widget.parent?.password);
    _addressController = TextEditingController(text: widget.parent?.address);

    _image = widget.image;
  }

  Future<void> _pickMediaFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg'],
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first;
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _addressController.dispose();

    super.dispose();
  }

  void _saveParent() async {
    if (_formKey.currentState!.validate()) {
      Parent parent = Parent(
        id: widget.parent?.id,
        fullName: _fullNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,

        address: _addressController.text,

        username: _usernameController.text,
        password: _passwordController.text,
        // parentID: widget.parent?.parentID ?? UniqueKey().toString(),
        // image: _image,
      );

      try {
        if (parent.id == null) {
          // If no parent ID exists, create a new parent
          await parentService.createParent(parent.toJson(), _image);
          if (widget.onAddParent != null) {
            widget.onAddParent!(parent);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('parent added successfully!')),
          );
        } else {
          // If a parent ID exists, update the existing parent
          await parentService.updateParent(parent.id!, parent);
          if (widget.onEditParent != null) {
            widget.onEditParent!(parent);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('parent updated successfully!')),
          );
        }
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  String? _validateEmail(String? value) {
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value == null || value.isEmpty) {
      return 'Enter email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }
@override
Widget build(BuildContext context) {
  return CustomPageLayout(
    child: Center( // Center the form
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          
          elevation: 6.0, // Add elevation to create shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85, // Limit the width of the form
            padding: const EdgeInsets.all(16.0), // Padding inside the Card
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person), // Add icon
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email), // Add icon
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone), // Add icon
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.account_circle), // Add icon
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock), // Add icon
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        prefixIcon: Icon(Icons.home), // Add icon
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      label: "Select files",
                      color: Colors.blue.shade100,
                      onPressed: _pickMediaFiles,
                    ),
                    if (_image != null) ...[
                      SizedBox(height: 10),
                      ListTile(
                        leading: Icon(
                          _image!.extension == 'pdf'
                              ? Icons.picture_as_pdf
                              : Icons.image,
                        ),
                        title: Text(_image!.name),
                        trailing: IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _image = null; // Remove the file
                            });
                          },
                        ),
                      ),
                    ],
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _saveParent,
                      icon: Icon(Icons.save), // Add icon
                      label: Text('Save'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}