import 'package:eskool/users/component/boxDesign.dart';
import 'package:flutter/material.dart';

import '../data/userImage.dart';
import 'introduction.dart';

Container Introduction_part(
  BuildContext context,
  String dayOfWeekShort,
  String day,
  String monthShort,
  String fullName,
  String email,
  String phone,
  String? imageUrl,
) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height / 4,
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
        SizedBox(height: 10),
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
                image: UserImageLoader.userImage(imageUrl),
              ),
            ),
            SizedBox(width: 20),
            Introduction(false, fullName, email, phone),
          ],
        ),
      ],
    ),
  );
}
