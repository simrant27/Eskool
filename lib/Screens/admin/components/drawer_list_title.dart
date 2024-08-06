import 'package:eskool/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerListTitle extends StatelessWidget {
  const DrawerListTitle(
      {super.key, required this.title, required this.icon, required this.tap});

  final String title;
  final IconData icon;
  final VoidCallback tap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tap,
      horizontalTitleGap: 20.0,
      leading: Icon(
        icon,
        color: grey,
      ),
      title: Text(title),
    );
  }
}
