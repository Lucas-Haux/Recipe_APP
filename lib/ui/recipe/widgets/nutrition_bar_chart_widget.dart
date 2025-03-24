import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:recipe_box/domain/models/recipe_model.dart';

class NutritionBarChartWidget extends StatelessWidget {
  final List<NutritionModel> nutrients;
  NutritionBarChartWidget({required this.nutrients, super.key});

  @override
  Widget build(BuildContext context) {
    // TODO make this a setting where you can add more/less
    // removes Alcohol nutrients
    final List<NutritionModel> newNutrients = nutrients
        .where((nutrition) => !nutrition.label!.contains('Alcohol'))
        .toList();

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: EdgeInsets.only(
          left: 0,
          right: 25,
          top: 10,
          bottom: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            Padding(
              padding: EdgeInsets.only(left: 25, bottom: 10),
              child: AutoSizeText(
                "Percentage of Recommended Daily Intake",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            // Barchart
            SizedBox(
              height: 700,
              child: _BarChart(
                nutrients: newNutrients,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  final List<NutritionModel> nutrients;
  const _BarChart({required this.nutrients});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: _getMaxY() + _getInterval(),
        rotationQuarterTurns: 1,
        titlesData: titlesData(),
        barGroups: barsData(),
        barTouchData: barValueLabel(),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          horizontalInterval: _getInterval(),
          show: true,
          drawVerticalLine: false,
          drawHorizontalLine: true,
        ),
        extraLinesData: ExtraLinesData(
          horizontalLines: <HorizontalLine>[
            HorizontalLine(
              y: _getMaxY() + _getInterval(),
              dashArray: defaultGridLine(0).dashArray,
              strokeWidth: defaultGridLine(0).strokeWidth,
              color: defaultGridLine(0).color,
            ),
          ],
        ),
      ),
    );
  }

  FlTitlesData titlesData() {
    // names of the nutrition labels
    Widget nutritionTitles(double value, TitleMeta meta) {
      final style = TextStyle(
        color: _percentageToColor(nutrients[value.toInt()].percentage!),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      );
      String text = nutrients[value.toInt()].label!;

      // Reduces size to fit in space
      if (text.contains('Carbohydrates')) {
        text = text.replaceFirst('Carbohydrates', 'Carbs');
      }

      return SideTitleWidget(
        meta: meta,
        space: 2,
        child: Text(text, style: style),
      );
    }

    // percentage scale
    Widget percentageTitles(double value, TitleMeta meta) {
      final style = TextStyle(
        color: _percentageToColor(value),
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

    return FlTitlesData(
      show: true,
      // Left side, Nutrition Labels
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 100,
          getTitlesWidget: nutritionTitles,
        ),
      ),
      // Top, Bar scale Labels
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          interval: _getInterval(),
          maxIncluded: true,
          showTitles: true,
          reservedSize: 22,
          getTitlesWidget: percentageTitles,
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  BarTouchData barValueLabel() {
    return BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (group) => Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 10,
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          return BarTooltipItem(
            "${rod.toY.round().toString()}%",
            TextStyle(
              color: _percentageToColor(nutrients[groupIndex].percentage!),
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }

  LinearGradient _percentageToGradient(double value) {
    LinearGradient gradient() {
      double stopDivider = value / 17;

      //double stopDivider = value / 15.152;
      List<double> stops = [];

      for (int i = 0; i < 12; i++) {
        //if (stops.length > 3) stopDivider = value / 16;
        stops.add(i / stopDivider);
      }

      return LinearGradient(
        colors: _gradientColors,
        stops: stops,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
    }

    return gradient();
  }

  List<BarChartGroupData> barsData() {
    return List.generate(
      nutrients.length,
      (index) {
        NutritionModel nutrition = nutrients[index];
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: nutrition.percentage!.roundToDouble(),
              //toY: 100,
              gradient: _percentageToGradient(nutrition.percentage!),
            ),
          ],
          showingTooltipIndicators: [0],
        );
      },
    );
  }

  double _getMaxY() {
    // get Biggest Percentage from all nutrients
    double biggestGivenNum = nutrients
        .map((nutrition) => nutrition.percentage!)
        .fold(0, (prev, element) => element > prev ? element : prev);

    // List of numbers from 0 to 400, incrementing by 20
    List<double> thresholds =
        List.generate(21, (index) => index * _getInterval());

    return thresholds
        .reduce((closest, current) => (current - biggestGivenNum).abs() <
                (closest - biggestGivenNum).abs()
            ? current
            : closest)
        .roundToDouble();
  }

  double _getInterval() {
    double biggestGivenNum = nutrients
        .map((nutrition) => nutrition.percentage!)
        .fold(0, (prev, element) => element > prev ? element : prev);

    switch (biggestGivenNum) {
      case <= 20:
        return 5;
      case > 20 && < 50:
        return 10;
      case >= 50 && < 100:
        return 20;
      case >= 100 && < 150:
        return 25;
      case >= 150:
        return 50;
      default:
        return 50;
    }
  }
}

Color _percentageToColor(double value) {
  value = (value / 12.5) - 2;

  if (value < 1) value = 1;
  if (value > 11) value = 11;

  return _gradientColors[value.round()];
}

List<Color> _gradientColors = [
  Color(0xFFF80000), // 0
  Color(0xFFEC3A00), // 16.66
  Color(0xFFD65C00), // 33.66
  Color(0xFFB57700), // 50
  Color(0xFF898B00), // 66.66
  Color(0xFF4C9900), // 83.66
  Color(0xFF4C9900), // 100
  Color(0xFF898B00), // 117
  Color(0xFFB57700), // 127
  Color(0xFFD65C00), // 135
  Color(0xFFEC3A00), // 140
  Color(0xFFF80000), //150
];
