import 'package:eskool/constants/constants.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final hintext;
  const SearchField({super.key, required this.hintext});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Search for $hintext",
          helperStyle:
              TextStyle(color: textColor.withOpacity(0.5), fontSize: 15),
          fillColor: secondaryColor,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          prefixIcon: Icon(
            Icons.search,
            color: textColor.withOpacity(0.5),
          )),
    );
  }
}
