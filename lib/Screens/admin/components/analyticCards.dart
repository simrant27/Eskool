import 'package:eskool/constants/constants.dart';
import 'package:eskool/constants/responsive.dart';
import 'package:eskool/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'analyticinfocard.dart';

class AnalyticCards extends StatelessWidget {
  const AnalyticCards({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Responsive(
        mobile: AnalyticInfoCardGridView(
          // crossAxisCount: size.width < 800 ? 2 : 3,
          childAspectRatio: size.width < 800 ? 1.7 : 1.5,
        ),
        tablet: AnalyticInfoCardGridView(),
        desktop: AnalyticInfoCardGridView(),
      ),
    );
  }
}

class AnalyticInfoCardGridView extends StatelessWidget {
  const AnalyticInfoCardGridView(
      {super.key, this.crossAxisCount = 3, this.childAspectRatio = 1.4});
  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: analyticData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: appPadding,
          mainAxisSpacing: appPadding,
          childAspectRatio: childAspectRatio),
      itemBuilder: (context, index) => AnalyticInfoCard(
        info: analyticData[index],
      ),
      // itemCount: analyticdata.length,
    );
  }
}
