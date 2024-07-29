import 'package:epic/cores/app_constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LevelProgressBody extends StatelessWidget {
  final Map<String, int> strategyLevels;

  const LevelProgressBody({
    required this.strategyLevels,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final maxLevel = (strategyLevels.values.isNotEmpty)
        ? strategyLevels.values.reduce((a, b) => a > b ? a : b)
        : 50;
    return Scaffold(
      backgroundColor: AppConstants.primaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Level Indicator',
              style: TextStyle(
                color: AppConstants.tertiaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  barTouchData: barTouchData,
                  titlesData: titlesData,
                  borderData: borderData,
                  barGroups: barGroups,
                  gridData: const FlGridData(show: false),
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxLevel.toDouble() + 5,
                  backgroundColor: AppConstants.tertiaryColor.withOpacity(0.1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppConstants.tertiaryColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppConstants.secondaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Inhibition';
        break;
      case 1:
        text = 'Memory';
        break;
      case 2:
        text = 'Planning';
        break;
      case 3:
        text = 'Self Regulation';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

// List<BarChartGroupData> _buildBarGroups() {
//     return model.asMap().entries.map((entry) {
//       int index = entry.key;
//       StrategyModel model = entry.value;

//       return BarChartGroupData(
//         x: index,
//         barRods: [
//           BarChartRodData(
//             toY: model.level.toDouble(),
//             gradient: _barsGradient,
//           )
//         ],
//         showingTooltipIndicators: [0],
//       );
//     }).toList();
//   }
  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: strategyLevels['Inhibition']?.toDouble() ?? 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: strategyLevels['Memory']?.toDouble() ?? 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: strategyLevels['Planning']?.toDouble() ?? 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: strategyLevels['Self Regulation']?.toDouble() ?? 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
