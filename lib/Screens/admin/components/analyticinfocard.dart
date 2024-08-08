import 'package:eskool/constants/constants.dart';
import 'package:eskool/models/analytic_info_model.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class AnalyticInfoCard extends StatelessWidget {
  const AnalyticInfoCard({super.key, required this.info});

  final AnalyticInfo info;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: appPadding, vertical: appPadding / 2),
      decoration: BoxDecoration(
        // color: info.color!.withOpacity(0.1),
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 195, 221, 243).withOpacity(0.8),
            offset: Offset(0, 2), // changes position of shadow
            blurRadius: 6, // softens the shadow
            // spreadRadius: 1, // extends the shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            info.icon!,
            color: info.color!.withOpacity(0.8),
            size: size.width * 0.06,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "${info.count}",
              style: TextStyle(
                  color: textColor, fontSize: 20, fontWeight: FontWeight.w300),
            ),
            Text(
              info.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18, color: textColor, fontWeight: FontWeight.w400),
            )

            // Container(
            //   padding: EdgeInsets.all(appPadding / 2),
            //   height: 40,
            //   width: 40,
            //   decoration: BoxDecoration(
            //       color: info.color!.withOpacity(0.1), shape: BoxShape.circle),
            //   child: Icon(
            //     info.icon!,
            //     color: info.color,
            //   ),
            // ),
          ]),
        ],
      ),
    );
  }
}
