// lib/widgets/delete_confirmation_dialog.dart

import 'package:eskool/Screens/admin/admindashboard/admindashboard.dart';
import 'package:eskool/Screens/admin/admindashboard/components/dashboard_content.dart';
import 'package:eskool/Screens/admin/admindashboard/components/notice_list.dart';
import 'package:flutter/material.dart';

void showDeleteConfirmationDialog(
    BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete Confirmation"),
        content: Text("Are you sure you want to delete this notice?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              onConfirm(); // Execute the delete logic

              Navigator.of(context).pop(); // Close the dialog
              // Redirect to dashboard
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Admindashboard()));
            },
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
