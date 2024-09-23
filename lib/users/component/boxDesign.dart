// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

BoxDecoration boxDesign() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFFD4E7FE),
        Color(0xFFF0F0F0),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      // stops: [0.6, 0.3],
    ),
  );
}
