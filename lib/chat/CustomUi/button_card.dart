import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({super.key, required this.name, this.icon});
  final String name;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 23,
        backgroundColor: Colors.blueGrey[200],
        child: Icon(icon),
      ),
      title: Text(
        name,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
