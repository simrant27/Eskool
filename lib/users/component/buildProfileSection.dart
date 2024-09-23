// Build Personal Information Section
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../data/data.dart';

Widget buildProfileSection(String title, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      details['name'] ?? Text(''), // Ensure fallback values
      SizedBox(height: 10),
      details['email'] ?? Text(''),
      SizedBox(height: 6),
      details['number'] ?? Text(''),
    ],
  );
}
