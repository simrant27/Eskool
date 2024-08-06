import 'package:flutter/material.dart';

import 'profileInfo.dart';
import 'searchField.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Expanded(child: SearchField()), ProfileInfo()],
    );
  }
}
