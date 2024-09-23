// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

List<Gradient> boxGradients = [
  LinearGradient(
    colors: [
      Color(0xFFB3E5FC),
      Color(0xFF81D4FA)
    ], // Light blue to slightly darker blue
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  LinearGradient(
    colors: [Color(0xFF80DEEA), Color(0xFFE0F7FA)], // Teal to light cyan
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  LinearGradient(
    colors: [Color(0xFFFEA3A0), Color(0xFFFAE3E3)], // Soft coral to light pink
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  LinearGradient(
    colors: [Color(0xFFB9FBC0), Color(0xFFE2F4C3)], // Mint green to light lime
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  LinearGradient(
    colors: [Color(0xFFFAC8D0), Color(0xFFC8E6C9)], // Soft pink to light green
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),

  // Add more gradients as needed
];
