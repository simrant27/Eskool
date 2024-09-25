import 'package:eskool/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Screens/admin/admindashboard/admindashboard.dart';

void showDeleteConfirmationDialog(
    BuildContext context, String noticeId, VoidCallback onDeleteSuccess) {
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
            onPressed: () async {
              // Call the backend to delete the notice using the MongoDB ObjectId
              try {
                await deleteNotice(noticeId);
                onDeleteSuccess(); // Callback to update the UI
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Notice deleted successfully'),
                  ),
                );
                Navigator.of(context).pop(); // Close the dialog
                // Redirect or refresh UI
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Admindashboard()));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete notice'),
                  ),
                );
              }
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

// Function to delete notice from the backend using the MongoDB ObjectId
Future<void> deleteNotice(String noticeId) async {
  print("Notice ID: $noticeId");

  final response = await http.delete(
    Uri.parse('$url/api/notices/$noticeId'),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  print('Response Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');
  print('Response Headers: ${response.headers}');

  if (response.statusCode == 200) {
    print('Notice deleted successfully');
  } else {
    print('Failed to delete notice');
    throw Exception('Failed to delete notice');
  }
}
