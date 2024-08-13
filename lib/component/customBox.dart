import 'package:flutter/material.dart';

Widget customBox( String title, IconData icon) {
  return Card(
    child: Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Icon(icon, size: 30),
         
        ],
      ),
    ),
  );
}
