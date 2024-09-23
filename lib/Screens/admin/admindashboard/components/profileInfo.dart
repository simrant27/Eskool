import 'package:eskool/constants/constants.dart';
import 'package:eskool/constants/responsive.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          // margin: EdgeInsets.only(left: appPadding),
          padding: EdgeInsets.symmetric(
              horizontal: appPadding, vertical: appPadding / 2),
          child: Row(
            children: [
              ClipRRect(
                child: Image.asset(
                  "assets/images/logowithtext.png",
                  height: 38,
                  width: 38,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(30),
              )
            ],
          ),
        ),
        if (!Responsive.isMobile(context))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: appPadding / 2),
            child: Text(
              "Hi! Admin",
              style: TextStyle(color: textColor, fontWeight: FontWeight.w800),
            ),
          )
      ],
    );
  }
}
