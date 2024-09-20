import 'package:flutter/material.dart';

import '../admindashboard/components/customAppbar.dart';
import '../admindashboard/components/responsive_drawer_layout.dart';

class CustomPageLayout extends StatelessWidget {
  final String? hinttext;
  final bool? showSearch;
  final Widget child;

  const CustomPageLayout({
    super.key,
    this.hinttext,
    this.showSearch,
    required this.child,
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
