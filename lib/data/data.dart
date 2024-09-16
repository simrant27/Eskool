// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

final Map<String, Widget> introduction = {
  'greeting': Text(
    "Hi Jackie",
    style: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w900,
      color: Color(0XFF343E87),
    ),
  ),
  'RegNO': Text(
    " Reg No: 1234",
    style: TextStyle(
      fontSize: 18,
      color: Colors.blueGrey,
    ),
  ),
  'Standard': Text(
    "Standard : 6th",
    style: TextStyle(
      fontSize: 16,
      color: Colors.blueGrey,
    ),
  ),
};
final Map<String, Widget> details = {
  'name': Text(" Jackie", style: TextStyle(fontSize: 18)),
  'email': Text(" Email : asmita@gmail", style: TextStyle(fontSize: 18)),
  'number': Text("number : 98111111", style: TextStyle(fontSize: 18)),
};
