import 'package:eskool/constants/constants.dart';
import 'package:eskool/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'analyticinfocard.dart';

class AnalyticCards extends StatelessWidget {
  const AnalyticCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnalyticInfoCardGridView(),
    );
  }
}

class AnalyticInfoCardGridView extends StatelessWidget {
  const AnalyticInfoCardGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: analyticData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: appPadding,
          mainAxisSpacing: appPadding,
          childAspectRatio: 1.4),
      itemBuilder: (context, index) => AnalyticInfoCard(
        info: analyticData[index],
      ),
      // itemCount: analyticdata.length,
    );
  }
}
