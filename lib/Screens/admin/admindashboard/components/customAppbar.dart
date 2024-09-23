import 'package:flutter/material.dart';

import 'profileInfo.dart';
import 'searchField.dart';

class CustomAppbar extends StatelessWidget {
  final hinttext;
  final Function(String)? onChanged;

  final bool? showSearch;
  const CustomAppbar(
      {super.key, required this.hinttext, this.showSearch, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (showSearch == true)
          Expanded(
              child: SearchField(
            hintext: hinttext,
            onChanged: onChanged,
          )),
        ProfileInfo()
      ],
    );
  }
}
