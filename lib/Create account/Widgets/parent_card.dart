import 'package:flutter/material.dart';

class ParentCard extends StatelessWidget {
  final Map<String, dynamic> parent;

  ParentCard({required this.parent});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${parent['fullName']}', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Email: ${parent['email']}'),
            Text('Phone: ${parent['phone']}'),
            Text('Child Name: ${parent['childrenDetails'].map((child) => child['name']).join(', ')}'),
          ],
        ),
      ),
    );
  }
}
