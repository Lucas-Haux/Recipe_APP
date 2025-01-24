import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:recipe_box/domain/models/recipe_model.dart';

class NutritionWidget extends StatelessWidget {
  final List<NutritionModel> nutrients;
  const NutritionWidget({required this.nutrients, super.key});

  @override
  Widget build(BuildContext context) {
    // removes Alcohol nutrients
    final List<NutritionModel> newNutrients = nutrients
        .where((nutrition) => !nutrition.label.contains('Alcohol'))
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        left: 0,
        right: 20,
        top: 10,
        bottom: 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 700,
            child: _BarChart(
              nutrients: newNutrients,
            ),
          ),
        ],
      ),
    );
  }
}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

class _BarChart extends StatelessWidget {
  final List<NutritionModel> nutrients;
  const _BarChart({required this.nutrients});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        extraLinesData: ExtraLinesData(
          horizontalLines: <HorizontalLine>[
            HorizontalLine(
              y: _getMaxY(),
              dashArray: defaultGridLine(0).dashArray,
              strokeWidth: defaultGridLine(0).strokeWidth,
              color: defaultGridLine(0).color,
            ),
          ],
        ),
        rotationQuarterTurns: 1,
        titlesData: titlesData,
        barTouchData: barTouchData,
        borderData: borderData,
        barGroups: barGroups(),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          drawHorizontalLine: true,
        ),
        alignment: BarChartAlignment.spaceAround,
        maxY: _getMaxY(),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 3,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppColors.contentColorCyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getNutritionTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.contentColorBlue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = nutrients[value.toInt()].label;

    // Reduces size to fit in space
    if (text.contains('Carbohydrates')) {
      text = text.replaceFirst('Carbohydrates', 'Carbs');
    }

    //Add amount value
    text = text +
        ' ' +
        nutrients[value.toInt()].amount.round().toString() +
        nutrients[value.toInt()].unit;

    return SideTitleWidget(
      meta: meta,
      space: 2,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 138,
            getTitlesWidget: getNutritionTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: getValueTitles,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  Widget getValueTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.contentColorBlue,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(
        ' ${meta.formattedValue}%',
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          AppColors.contentColorBlue,
          AppColors.contentColorCyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> barGroups() {
    return List.generate(
      nutrients.length,
      (index) {
        NutritionModel nutrition = nutrients[index];
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: nutrition.percentage,
              gradient: _barsGradient,
            ),
          ],
          showingTooltipIndicators: [0],
        );
      },
    );
  }

  double _getMaxY() {
    // get Biggest Percentage from all nutrients
    double biggestNum = 0;
    for (NutritionModel nutrition in nutrients) {
      if (nutrition.percentage > biggestNum) {
        biggestNum = nutrition.percentage.roundToDouble();
      }
    }

    if (biggestNum >= 101) {
      List<double> thresholds = [125, 150, 175, 200, 225, 250, 275, 300];
      for (double threshold in thresholds) {
        if (biggestNum <= threshold) {
          biggestNum = threshold;
          break;
        }
      }
    }

    return biggestNum;
  }
}
