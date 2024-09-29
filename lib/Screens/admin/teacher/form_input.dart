import 'package:flutter/material.dart';

class FormInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;

  FormInputField({
    required this.label,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      obscureText: isPassword,
      validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
    );
  }
}
