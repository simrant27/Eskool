import 'package:eskool/Screens/admin/components/customAppbar.dart';
import 'package:flutter/material.dart';
import '../../models/notice_info_model.dart';
import 'components/notice_list.dart';
import 'components/responsive_drawer_layout.dart'; // Import the new widget

class CreateNoticePage extends StatelessWidget {
  const CreateNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveDrawerLayout(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppbar(
                  hinttext: "notices",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
