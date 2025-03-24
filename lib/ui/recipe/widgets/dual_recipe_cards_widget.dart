import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:recipe_box/ui/recipe/widgets/nutrition_bar_chart_widget.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../domain/models/recipe_model.dart';

class DualRecipeCards extends StatelessWidget {
  final double cardWidth;
  final RecipeModel recipe;
  const DualRecipeCards(
      {required this.cardWidth, required this.recipe, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      height: 190,
      child: Row(
        children: [
          // Serving Amounts and Serving Details
          _ServingsInfoCard(
            cardWidth: cardWidth,
            servings: recipe.servings,
            calories: recipe.calories,
            fat: recipe.fat,
            protein: recipe.protein,
            pricePerServing: recipe.pricePerServing,
          ),
          const Spacer(),
          // Recipe Link, Time, Health, and More
          _MicInfoCard(
            cardWidth: cardWidth,
            sourceUrl: recipe.sourceUrl,
            sourceName: recipe.sourceName,
            time: recipe.time,
            ingredients: recipe.ingredients,
            weightWatcher: recipe.weightWatcher,
            healthScore: recipe.healthScore,
            nutrients: recipe.nutrients!,
          ),
        ],
      ),
    );
  }
}

class _ServingsInfoCard extends StatelessWidget {
  final double cardWidth;
  final int servings;
  final int calories;
  final int fat;
  final int protein;
  final double pricePerServing;
  const _ServingsInfoCard({
    required this.cardWidth,
    required this.servings,
    required this.calories,
    required this.fat,
    required this.protein,
    required this.pricePerServing,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth / 2.05,
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 29,
              child: Text(
                servings > 1
                    ? '$servings Servings' // plural
                    : '$servings Serving', // Single
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const Divider(),
            const Text(
              'Per Serving:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              ' \$${pricePerServing.toStringAsFixed(2)} USD',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.grey.shade300,
              ),
            ),
            _NumbersTextRichText(
                start: '$calories',
                end: (calories > 1) ? ' Calories' : ' Calorie'),
            _NumbersTextRichText(start: '${protein}g', end: ' of Protein'),
            _NumbersTextRichText(start: '${fat}g', end: ' of Fat'),
            const Spacer(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _MicInfoCard extends StatelessWidget {
  final double cardWidth;
  final String sourceUrl;
  final String sourceName;
  final int time;
  final List<String> ingredients;
  final int weightWatcher;
  final double healthScore;
  final List<NutritionModel> nutrients;
  const _MicInfoCard({
    required this.cardWidth,
    required this.sourceUrl,
    required this.sourceName,
    required this.time,
    required this.ingredients,
    required this.weightWatcher,
    required this.healthScore,
    required this.nutrients,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth / 2.05,
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Column(
          children: [
            const SizedBox(height: 10),

            // nutrition button
            SizedBox(
              height: 29,
              child: FilledButton(
                onPressed: () {
                  showDialog(
                    useSafeArea: false,
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      child: NutritionBarChartWidget(nutrients: nutrients),
                      insetPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                  );
                },
                child: const Text(
                  'Nutrition Data',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),

            const Divider(),
            const SizedBox(height: 4),

            // Source Url Button
            SizedBox(
              height: 29,
              child: OutlinedButton(
                onPressed: () async {
                  final Uri url = Uri.parse(sourceUrl);
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
                  foregroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.tertiary),
                  side: WidgetStatePropertyAll(BorderSide(
                      color: Theme.of(context).colorScheme.tertiary)),
                ),
                child: AutoSizeText(
                  sourceName,
                  style: const TextStyle(height: 0.5),
                  maxLines: 1,
                ),
              ),
            ),

            const Spacer(),
            _TextNumbersRichText(start: 'Ready In: ', end: '${time}m'),
            const Spacer(),
            _TextNumbersRichText(
                start: 'Weight Watcher Score: ', end: weightWatcher.toString()),

            const Spacer(),
            _TextNumbersRichText(
                start: 'Health Score: ', end: healthScore.toInt().toString()),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _NumbersTextRichText extends StatelessWidget {
  final String start;
  final String end;
  const _NumbersTextRichText({
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    double _fontSize = 15;
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5, top: 1.5),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            // Numbers
            TextSpan(
              text: start,
              style: TextStyle(
                fontSize: _fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),

            TextSpan(
              text: end,
              style: TextStyle(
                fontSize: _fontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextNumbersRichText extends StatelessWidget {
  final String start;
  final String end;
  const _TextNumbersRichText({
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    double _fontSize = 15;
    return Padding(
      padding: EdgeInsets.only(bottom: 3),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            // Numbers
            TextSpan(
              text: start,
              style: TextStyle(
                fontSize: _fontSize - 1,
                fontWeight: FontWeight.normal,
              ),
            ),

            TextSpan(
              text: end,
              style: TextStyle(
                fontSize: _fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
