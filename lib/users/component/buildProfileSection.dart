// Build Personal Information Section
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget buildProfileSection(String title, BuildContext context, String fullName,
    String email, String phone) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 15),
      Text(
        "Hi $fullName",
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      SizedBox(height: 10),
      Text(
        'Email: $email',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      SizedBox(height: 6),
      Text(
        'Number: $phone',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      SizedBox(height: 8),
    ],
  );
}
