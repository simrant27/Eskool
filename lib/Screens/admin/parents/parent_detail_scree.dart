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
                Image.network(
                  "$NoticeImage/${parent.image}",
                  fit: BoxFit.cover,
                ),
              ]
            ],
            // Display parent Image
            // Center(
            //   child: Container(
            //       child: parent.image != null
            //           ? Image.network("$parentImage/${parent.image!}")
            //           : Text("no data")),
            // if (parent.image != null) ...[
            //   // For image files
            //   if (parent.image!.endsWith('.jpg') ||
            //       parent.image!.endsWith('.png') ||
            //       parent.image!.endsWith('.jpeg')) ...[
            //     Image.network(
            //       "$parentImage/$parent.image",
            //       fit: BoxFit.cover,
            //     ),
            //   ]
            // ],
            //  CircleAvatar(
            //   radius: 50,
            //   // backgroundImage:
            //   //     AssetImage("assets/images/default_profile.png"),
            //   backgroundImage: parent.image != null
            //       ? Image.network(parent.image!):Text("no data");// Assuming image is a URL
            //   // Default image if no image available
            // ),

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
