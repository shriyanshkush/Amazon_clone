import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/sales.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> salesData;

  const CategoryProductsChart({
    Key? key,
    required this.salesData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Add padding around the chart
      child: BarChart(
        BarChartData(
          barGroups: _generateBarGroups(),
          titlesData: _generateTitles(),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey, width: 1),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 100, // Adjust intervals for better readability
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.grey.withOpacity(0.5),
              strokeWidth: 0.5,
            ),
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${salesData[groupIndex].label}\n',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Earnings: \$${rod.toY.toInt()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Generates bar groups for the chart.
  List<BarChartGroupData> _generateBarGroups() {
    return salesData.asMap().entries.map((entry) {
      int index = entry.key;
      Sales data = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data.earning.toDouble(),
            color: Colors.blue,
            width: 20, // Adjust bar width
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }

  /// Generates titles for the chart.
  FlTitlesData _generateTitles() {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          interval: 200, // Adjust interval based on your data
          getTitlesWidget: (value, meta) {
            return Text(
              '\$${value.toInt()}',
              style: const TextStyle(fontSize: 12),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index >= 0 && index < salesData.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  salesData[index].label,
                  style: const TextStyle(fontSize: 9),
                  overflow: TextOverflow.ellipsis, // Handle long text
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
