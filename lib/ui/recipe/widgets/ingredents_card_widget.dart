import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';

import '../../../domain/models/recipe_model.dart';

class IngredentsCard extends StatelessWidget {
  final double cardWidth;
  final TextStyle titleStyle;
  final List<String> ingredients;
  const IngredentsCard({
    required this.cardWidth,
    required this.titleStyle,
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
            Text('Ingredients:', style: titleStyle),
            const Divider(),
            // Column of Ingredient Names
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
