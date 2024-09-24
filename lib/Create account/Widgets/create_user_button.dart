import 'package:flutter/material.dart';

class CreateUserButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  CreateUserButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Text(title),
    );
  }
}
