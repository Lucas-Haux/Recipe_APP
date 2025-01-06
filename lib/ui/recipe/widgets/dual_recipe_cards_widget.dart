import 'package:flutter/material.dart';

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
          ),
        ],
      ),
    );
  }
}

class _ServingsInfoCard extends StatelessWidget {
  final double cardWidth;
  final int servings;
  final String calories;
  final String fat;
  final String protein;
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
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            const Text(
              'Per Serving:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(' $calories '),
            Text(' $protein '),
            Text(' $fat '),
            Text(' \$${pricePerServing.toStringAsPrecision(2)} USD'),
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
  final int healthScore;
  const _MicInfoCard({
    required this.cardWidth,
    required this.sourceUrl,
    required this.sourceName,
    required this.time,
    required this.ingredients,
    required this.weightWatcher,
    required this.healthScore,
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

            // Source Url Button
            SizedBox(
              height: 29,
              child: FilledButton(
                onPressed: () async {
                  final Uri url = Uri.parse(sourceUrl);
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
                  backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.tertiary),
                ),
                child: Text(
                  sourceName,
                  style: const TextStyle(height: 0.5),
                ),
              ),
            ),
            const Divider(),
            const Spacer(),
            Text('Time To Cook: ${time}m'),
            const Spacer(),
            Text('Total Ingredients: ${ingredients.length}'),
            const Spacer(),
            Text('Weight Watcher: ${weightWatcher.toString()}'),
            const Spacer(),
            Text('Health Score: ${healthScore.toString()}'),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
