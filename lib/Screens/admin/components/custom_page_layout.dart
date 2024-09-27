import 'package:eskool/users/component/customAppBar2.dart';
import 'package:flutter/material.dart';

import '../admindashboard/components/customAppbar.dart';
import '../admindashboard/components/responsive_drawer_layout.dart';

class CustomPageLayout extends StatelessWidget {
  final String? hinttext;
  final Function(String)? onChanged;
  final bool? showSearch;
  final bool? showBackButton;
  final bool? showCustomLayout;

  final Widget child;

  const CustomPageLayout({
    super.key,
    this.hinttext,
    this.showSearch,
    this.onChanged,
    this.showBackButton,
    required this.child,
    this.showCustomLayout = true,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbar(
                  hinttext: hinttext,
                  showSearch: showSearch,
                  onChanged: onChanged,
                  showBackButton: showBackButton,
                ),
                SizedBox(height: 20),
                child, // The content of the page
              ],
            ),
          ),
        ),
      ),
    );
  }
}
