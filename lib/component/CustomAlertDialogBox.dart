import 'package:flutter/material.dart';

Future CustomAlertDialogBox(
  BuildContext context,
  String title,
  String content,
  List<Widget> actions, // Custom actions
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions, // Use the custom actions passed in
      );
    },
  );
}
