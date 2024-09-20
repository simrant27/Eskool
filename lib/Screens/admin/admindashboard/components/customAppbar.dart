import 'package:flutter/material.dart';

import 'profileInfo.dart';
import 'searchField.dart';

class CustomAppbar extends StatelessWidget {
  final hinttext;
  final bool? showSearch;
  const CustomAppbar({super.key, required this.hinttext, this.showSearch});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (showSearch == true)
          Expanded(
              child: SearchField(
            hintext: hinttext,
          )),
        ProfileInfo()
      ],
    );
  }
}
