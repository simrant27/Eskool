// Build Security Section
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget buildSecuritySection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Security & Privacy",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      ListTile(
        leading: Icon(Icons.lock, color: Colors.blue),
        title: Text("Change Password", style: TextStyle(fontSize: 18)),
        onTap: () {
          // Handle change password action
        },
      ),
    ],
  );
}
