// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

final ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Custom padding
  backgroundColor: Color(0xFF80DEEA), // Button background color
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12), // Rounded corners
  ),
  textStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold, // Text styling
  ),
);
