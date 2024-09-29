import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ParentFormPopup extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final Map<String, dynamic>? existingData; // Optional parameter for editing

  ParentFormPopup({required this.onSubmit, this.existingData});

  @override
  _ParentFormPopupState createState() => _ParentFormPopupState();
}

class _ParentFormPopupState extends State<ParentFormPopup> {
  final _formKey = GlobalKey<FormState>();
  String? fullName, email, phone, address, relationship, occupation, username, password, parentID;
  List<Map<String, dynamic>> childrenDetails = [];
  File? parentPhoto;
  final ImagePicker picker = ImagePicker();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingData != null) {
      // Load existing data into fields for editing
      fullName = widget.existingData!['fullName'];
      email = widget.existingData!['email'];
      phone = widget.existingData!['phone'];
      address = widget.existingData!['address'];
      relationship = widget.existingData!['relationship'];
      occupation = widget.existingData!['occupation'];
      parentID = widget.existingData!['parentID'];
      username = widget.existingData!['username'];
      password = widget.existingData!['password'];
      childrenDetails = List.from(widget.existingData!['childrenDetails']);
      parentPhoto = widget.existingData!['photo'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existingData == null ? 'Parent Account Form' : 'Edit Parent Account'),
      content: SingleChildScrollView(
        child: Container(
          width: 400,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildFormField('Full Name', Icons.person, (value) => fullName = value, initialValue: fullName),
                SizedBox(height: 10),
                buildFormField('Email Address', Icons.email, (value) => email = value, emailValidator: true, initialValue: email),
                SizedBox(height: 10),
                buildFormField('Phone Number', Icons.phone, (value) => phone = value, phoneValidator: true, initialValue: phone),
                SizedBox(height: 10),
                buildFormField('Address', Icons.home, (value) => address = value, initialValue: address),
                SizedBox(height: 10),
                buildFormField('Relationship to the Child', Icons.family_restroom, (value) => relationship = value, initialValue: relationship),
                SizedBox(height: 10),
                buildFormField('Occupation (Optional)', Icons.work, (value) => occupation = value, initialValue: occupation),
                SizedBox(height: 10),
                buildFormField('Parent ID', Icons.badge, (value) => parentID = value, initialValue: parentID),
                SizedBox(height: 10),
                buildFormField('Username', Icons.person_outline, (value) => username = value, initialValue: username),
                SizedBox(height: 10),
                buildFormField('Password', Icons.lock, (value) => password = value, isPassword: true, initialValue: password),
                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      childrenDetails.add({'name': '', 'dob': '', 'gender': '', 'grade': '', 'id': '', 'address': '', 'photo': null});
                    });
                  },
                  child: Text('Add Child'),
                ),
                SizedBox(height: 10),

                // Children Details Fields
                ...childrenDetails.map((child) => buildChildDetails(child)).toList(),

                SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: isLoading ? CircularProgressIndicator() : Icon(Icons.photo),
                  label: Text('Add Photo'),
                  onPressed: () async {
                    setState(() => isLoading = true);
                    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        parentPhoto = File(pickedFile.path);
                        isLoading = false;
                      });
                    }
                  },
                ),
                parentPhoto != null
                    ? Image.file(parentPhoto!, height: 100, width: 100)
                    : Container(),
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onSubmit({
                'fullName': fullName,
                'email': email,
                'phone': phone,
                'address': address,
                'relationship': relationship,
                'parentID': parentID,
                'occupation': occupation,
                'username': username,
                'password': password,
                'childrenDetails': childrenDetails,
                'photo': parentPhoto,
              });
              Navigator.pop(context);
            }
          },
          child: Text(widget.existingData == null ? 'Submit' : 'Update'),
        ),
      ],
    );
  }

  TextFormField buildFormField(String label, IconData icon, Function(String?) onSave, {bool emailValidator = false, bool phoneValidator = false, bool isPassword = false, String? initialValue}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        labelText: label,
        labelStyle: TextStyle(color: Colors.deepPurple),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      obscureText: isPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $label';
        }
        if (emailValidator && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        if (phoneValidator && !RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
      onSaved: onSave,
    );
  }

  Widget buildChildDetails(Map<String, dynamic> child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Child Details', style: TextStyle(fontWeight: FontWeight.bold)),
        buildFormField('Child Name', Icons.child_care, (value) => child['name'] = value),
        SizedBox(height: 10),
        buildFormField('Date of Birth', Icons.calendar_today, (value) => child['dob'] = value),
        SizedBox(height: 10),
        buildFormField('Gender', Icons.accessibility, (value) => child['gender'] = value),
        SizedBox(height: 10),
        buildFormField('Grade/Class', Icons.grade, (value) => child['grade'] = value),
        SizedBox(height: 10),
        buildFormField('School ID/Registration Number', Icons.school, (value) => child['id'] = value),
        SizedBox(height: 10),
        buildFormField('Address', Icons.home, (value) => child['address'] = value),
        SizedBox(height: 10),
      ],
    );
  }
}
