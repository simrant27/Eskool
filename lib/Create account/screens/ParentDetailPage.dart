import 'package:flutter/material.dart';

class ParentDetailPage extends StatelessWidget {
  final Map<String, dynamic> parent;

  ParentDetailPage({required this.parent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(parent['photoUrl']), // Assuming a URL for the photo
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${parent['fullName']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('Email: ${parent['email']}'),
                      Text('Phone: ${parent['phone']}'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Child Details:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            ...parent['childrenDetails'].map<Widget>((child) {
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Child Name: ${child['name']}, Age: ${child['age']}'), // Assuming there's an age field
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
