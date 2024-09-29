import 'package:eskool/Screens/admin/teacher/show_image.dart';
import 'package:eskool/models/ParentMode.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';

class ParentDetailScreen extends StatelessWidget {
  final Parent parent;

  ParentDetailScreen({required this.parent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(parent.fullName ?? 'parent Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            if (parent.image != null) ...[
              // For image files
              if (parent.image!.endsWith('.jpg') ||
                  parent.image!.endsWith('.png') ||
                  parent.image!.endsWith('.jpeg')) ...[
                showImage(parent.image, "parent")
              ]
            ],

            SizedBox(height: 16),
            // Display parent Details
            Text(
              'Full Name: ${parent.fullName ?? 'N/A'}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Email: ${parent.email ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Phone: ${parent.phone ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Username: ${parent.username ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Address: ${parent.address ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),

            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
