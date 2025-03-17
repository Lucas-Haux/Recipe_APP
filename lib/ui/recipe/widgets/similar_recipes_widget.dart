import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:recipe_box/ui/core/ui/recipe_display_card_widget.dart';

import '../../../domain/models/recipe_model.dart';

class SimilarRecipesWidget extends StatefulWidget {
  final int id;
  final List<SimilarRecipeModel>? givenSimilarRecipes;
  final Future<void> Function() searchForSimilarRecipes;
  final double cardWidth;
  const SimilarRecipesWidget({
    this.givenSimilarRecipes,
    required this.id,
    required this.searchForSimilarRecipes,
    required this.cardWidth,
    super.key,
  });
  @override
  State<SimilarRecipesWidget> createState() => _SimilarRecipesState();
}

class _SimilarRecipesState extends State<SimilarRecipesWidget> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;

    List<SimilarRecipeModel>? similarRecipes = widget.givenSimilarRecipes;

    CarouselController carouselController =
        CarouselController(initialItem: (similarRecipes?.length ?? 2) ~/ 2);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (similarRecipes == null)
          DottedBorder(
            padding: const EdgeInsets.symmetric(vertical: 75, horizontal: 100),
            dashPattern: const [6, 10],
            color: Theme.of(context).colorScheme.outlineVariant,
            strokeWidth: 2,
            strokeCap: StrokeCap.round,
            child: FilledButton(
              onPressed: () async {
                await widget.searchForSimilarRecipes();
              },
              child: const Text('Similar Recipes'),
            ),
          ),

        // Carousel
        if (similarRecipes != null)
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: height / 4.0),
            child: CarouselView.weighted(
              controller: carouselController,
              shrinkExtent: 500,
              itemSnapping: true,
              flexWeights: const <int>[2, 3, 2],
              children: similarRecipes.map((SimilarRecipeModel recipe) {
                return RecipeDisplayCardWidget(
                    expand: true,
                    imageUrl: recipe.imageUrl!,
                    title: recipe.title!,
                    recipeId: recipe.recipeId!,
                    cardWidth: widget.cardWidth);
              }).toList(),
            ),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}
