import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Container RectangleBox(String content) {
  return Container(
    margin: EdgeInsets.symmetric(
        horizontal: 30, vertical: 10), // Adjust margin for spacing
    padding: EdgeInsets.all(30),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 127, 195, 224),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        content,
        // Access fullName directly from the Student object
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
