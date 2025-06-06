import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:recipe_box/shared/themes/dimens.dart';

class IngredentsCard extends StatelessWidget {
  final double cardWidth;
  final List<String> ingredients;
  const IngredentsCard({
    required this.cardWidth,
    required this.ingredients,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      child: Card(
        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
        child: Column(
          children: [
            const SizedBox(height: 5),
            // Tile
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white.withAlpha(200),
                  ),
            ),
            const Divider(),
            // Column of Ingredient Names
            Padding(
              padding: Dimens.of(context).edgeInsetsScreenHorizontal,
              child: Column(
                children: ingredients.map((ingredient) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        StringUtils.capitalize(ingredient, allWords: true),
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
