import 'package:eskool/constants/constants.dart';
import 'package:flutter/material.dart';
import 'profileInfo.dart';
import 'searchField.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? hinttext;
  final Function(String)? onChanged;
  final bool? showSearch;
  final bool? showBackButton;

  const CustomAppbar({
    super.key,
    this.hinttext,
    this.showSearch,
    this.onChanged,
    this.showBackButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Disable default back button
      backgroundColor: bgColor,
      elevation: 2, // Add shadow below the AppBar
      leading: showBackButton == true
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black),
            )
          : null,
      title: showSearch == true
          ? SearchField(
              hintext: hinttext,
              onChanged: onChanged,
            )
          : null,
      actions: [
        ProfileInfo(),
      ],
      titleSpacing: 0, // Controls space between leading and title
    );
  }

  // This controls the height of your custom appbar.
  @override
  Size get preferredSize =>
      const Size.fromHeight(60); // You can adjust the height
}
