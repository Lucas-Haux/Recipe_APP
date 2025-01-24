import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';

import 'recipe_image_widget.dart';
import '../../../domain/models/similar_recipe_model.dart';

class SimilarRecipesWidget extends StatefulWidget {
  final int id;
  final Future<List<SimilarRecipeModel>> Function(int) searchForSimilarRecipes;
  final double cardWidth;
  const SimilarRecipesWidget({
    required this.id,
    required this.searchForSimilarRecipes,
    required this.cardWidth,
    super.key,
  });
  @override
  State<SimilarRecipesWidget> createState() => _SimilarRecipesState();
}

class _SimilarRecipesState extends State<SimilarRecipesWidget> {
  List<SimilarRecipeModel> similarRecipes = [];

  final PageController carouselController =
      PageController(initialPage: 1, viewportFraction: 1 / 2);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.cardWidth,
      child: Column(
        children: [
          if (similarRecipes.isEmpty)
            DottedBorder(
              padding:
                  const EdgeInsets.symmetric(vertical: 75, horizontal: 100),
              dashPattern: const [6, 10],
              color: Theme.of(context).colorScheme.outlineVariant,
              strokeWidth: 2,
              strokeCap: StrokeCap.round,
              child: FilledButton(
                onPressed: () async {
                  final newList =
                      await widget.searchForSimilarRecipes(widget.id);
                  setState(() {
                    similarRecipes = newList;
                  });
                },
                child: const Text('Similar Recipes'),
              ),
            ),

          // Carousel
          if (similarRecipes.isNotEmpty)
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: 250, maxWidth: widget.cardWidth),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                      Colors.black,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.1, 0.9, 1],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: PageView.builder(
                  controller: carouselController,
                  pageSnapping: false,
                  dragStartBehavior: DragStartBehavior.start,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  allowImplicitScrolling: true,
                  itemCount: similarRecipes.length,
                  itemBuilder: (context, index) {
                    return _SimilarRecipeCard(
                      recipe: similarRecipes[index],
                      cardWidth: widget.cardWidth,
                    );
                  },
                ),
              ),
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _SimilarRecipeCard extends StatelessWidget {
  final SimilarRecipeModel recipe;
  final double cardWidth;
  const _SimilarRecipeCard({required this.recipe, required this.cardWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {},
        child: Card(
          color: Theme.of(context).colorScheme.onSecondary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RecipeImage(
                imageUrl: recipe.imageUrl,
                favoriteButton: false,
                cardWidth: cardWidth,
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(recipe.title, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
