<<<<<<< HEAD
import 'package:flutter/material.dart';

import '../data/data.dart';
import '../data/userImage.dart';
import 'boxDesign.dart';

Stack Introduction_Part(BuildContext context, String dayOfWeekShort, String day,
    String monthShort) {
  return Stack(
    children: [
      Container(
        width: double.infinity, // Use full width
        height: MediaQuery.of(context).size.height / 3.7,
        decoration: boxDesign(),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: dayOfWeekShort,
                  style: TextStyle(
                    color: Color.fromARGB(255, 46, 121, 214),
                    fontSize: MediaQuery.of(context).size.height / 45,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(
                      text: ' $day $monthShort',
                      style: TextStyle(
                        color: Color(0XFF263064),
                        fontSize: MediaQuery.of(context).size.height / 50,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.height / 15,
                  height: MediaQuery.of(context).size.height / 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.2),
                        blurRadius: 12,
                        spreadRadius: 8,
                      ),
                    ],
                    image: userImage(),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    introduction['greeting'] ??
                        Text(''), // Ensure fallback values
                    SizedBox(height: 10),
                    introduction['email'] ?? Text(''),
                    SizedBox(height: 6),
                    introduction['number'] ?? Text(''),
                    SizedBox(height: 8),
                  ],
                ),
=======
import 'package:eskool/users/component/boxDesign.dart';
import 'package:flutter/material.dart';

import '../data/userImage.dart';

Container Introduction_part(
  BuildContext context,
  String dayOfWeekShort,
  String day,
  String monthShort,
  String fullName,
  String email,
  String phone,
) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height / 3.7,
    decoration: boxDesign(),
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
    child: Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: RichText(
            text: TextSpan(
              text: dayOfWeekShort,
              style: TextStyle(
                color: Color.fromARGB(255, 46, 121, 214),
                fontSize: MediaQuery.of(context).size.height / 45,
                fontWeight: FontWeight.w900,
              ),
              children: [
                TextSpan(
                  text: ' $day $monthShort',
                  style: TextStyle(
                    color: Color(0XFF263064),
                    fontSize: MediaQuery.of(context).size.height / 50,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.height / 15,
              height: MediaQuery.of(context).size.height / 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.2),
                    blurRadius: 12,
                    spreadRadius: 8,
                  ),
                ],
                image: userImage(),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
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
>>>>>>> main
              ],
            ),
          ],
        ),
<<<<<<< HEAD
      ),
    ],
=======
      ],
    ),
>>>>>>> main
  );
}
