import 'package:eskool/constants/constants.dart';
import 'package:eskool/constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/drawerController.dart';
import 'profileInfo.dart';
import 'searchField.dart';

class CustomAppbar extends StatelessWidget {
  final hinttext;
  const CustomAppbar({super.key, required this.hinttext});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            onPressed: context.read<Controller>().controlMenu,
            icon: Icon(Icons.menu),
            color: textColor.withOpacity(0.5),
          ),
        Expanded(
            child: SearchField(
          hintext: hinttext,
        )),
        ProfileInfo()
      ],
    );
  }
}
