import 'package:flutter/material.dart';
import '../data/menuItems.dart';

Widget customBox(MenuItem menuItem, Gradient boxGradient) {
  return Container(
    padding: EdgeInsets.all(10), // Reduced padding

    decoration: BoxDecoration(
      gradient: boxGradient, // Apply the gradient
      borderRadius: BorderRadius.circular(12), // Rounded corners
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 11, 9, 9).withOpacity(0.15),
          blurRadius: 6,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          menuItem.title,
          style: TextStyle(
            fontSize: 24, // Reduced font size
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(
                255, 84, 81, 87), // Ensure text is visible against the gradient
          ),
          textAlign: TextAlign.center, // Center align text
        ),
        SizedBox(height: 15), // Reduced spacing
        Icon(menuItem.icon,
            size: 40,
            color: const Color.fromARGB(
                255, 39, 34, 34)), // Adjust icon color for contrast
      ],
    ),
  );
}
