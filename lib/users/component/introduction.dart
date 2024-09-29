import 'package:flutter/material.dart';

Column Introduction(bool profile, String fullName, String email, String phone) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (profile) ...[
        Text(
          "Profile Information",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
      ],
      Text(
        profile ? 'Name : $fullName' : "Hi $fullName",
        style: TextStyle(
          fontSize: profile ? 18 : 25, // Conditionally adjust the font size
          fontWeight: profile ? FontWeight.normal : FontWeight.w900,
          color: profile ? Colors.black : Color(0XFF343E87),
        ),
      ),
      SizedBox(height: 10),
      Text(
        'Email : $email',
        style: TextStyle(
          fontSize: 18,
          color: profile ? Colors.black : Colors.blueGrey,
        ),
      ),
      SizedBox(height: 6),
      Text(
        'Number : $phone',
        style: TextStyle(
          fontSize: profile ? 18 : 16,
          color: profile ? Colors.black : Colors.blueGrey,
        ),
      ),
      SizedBox(height: 8),
    ],
  );
}
