import 'package:flutter/material.dart';

Column Introduction(String fullName, String email, String phone) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Hi $fullName",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w900,
          color: Color(0XFF343E87),
        ),
      ),
      SizedBox(height: 10),
      Text(
        'Email: $email',
        style: TextStyle(
          fontSize: 18,
          color: Colors.blueGrey,
        ),
      ),
      SizedBox(height: 6),
      Text(
        'Number: $phone',
        style: TextStyle(
          fontSize: 16,
          color: Colors.blueGrey,
        ),
      ),
      SizedBox(height: 8),
    ],
  );
}
