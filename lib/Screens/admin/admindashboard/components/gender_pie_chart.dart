import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GenderPieChart extends StatelessWidget {
  final int boysCount;
  final int girlsCount;
  final int othersCount;

  const GenderPieChart({
    super.key,
    required this.boysCount,
    required this.girlsCount,
    required this.othersCount,
  });

  @override
  Widget build(BuildContext context) {
    int total = boysCount + girlsCount + othersCount;

    double boysPercentage = (boysCount / total) * 100;
    double girlsPercentage = (girlsCount / total) * 100;
    double othersPercentage = (othersCount / total) * 100;

    return Container(
      width: 400,
      height: 280,
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Students",
                style: TextStyle(fontSize: 20),
              )),
          Expanded(
            flex: 4,
            child: PieChart(
              PieChartData(
                sections: [
                  _buildPieChartSection(
                      boysPercentage, Colors.blue.shade400, 'Boys'),
                  _buildPieChartSection(
                      girlsPercentage, Colors.pink.shade400, 'Girls'),
                  _buildPieChartSection(
                      othersPercentage, Colors.green, 'Others'),
                ],
                sectionsSpace: 0,
                centerSpaceRadius: 40,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIndicator(Colors.blue, 'Boys: ${boysCount.toString()}'),
                SizedBox(width: 16),
                _buildIndicator(Colors.pink, 'Girls: ${girlsCount.toString()}'),
                SizedBox(width: 16),
                _buildIndicator(
                    Colors.green, 'Others: ${othersCount.toString()}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PieChartSectionData _buildPieChartSection(
      double value, Color color, String title) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: '${value.toStringAsFixed(1)}%',
      radius: 60,
      titleStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildIndicator(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
