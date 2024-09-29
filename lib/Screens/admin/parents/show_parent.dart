// File: lib/widgets/parent_card.dart

import 'package:eskool/models/ParentMode.dart';
import 'package:flutter/material.dart';

class ParentCard extends StatelessWidget {
  final Parent parent;
  final Function() onEdit;
  final Function() onDelete;

  const ParentCard({
    Key? key,
    required this.parent,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              parent.fullName ?? 'No Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${parent.email ?? 'No Email'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Phone: ${parent.phone ?? 'No Phone'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
