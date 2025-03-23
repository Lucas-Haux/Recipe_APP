import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:recipe_box/ui/core/ui/recipe_display_card_widget.dart';

import 'package:shimmer/shimmer.dart';

import '../../../domain/models/recipe_model.dart';

class SimilarRecipesWidget extends StatefulWidget {
  final int recipeId;
  final List<SimilarRecipeModel>? similarRecipesList;
  final Future<void> Function() searchForSimilarRecipes;
  final double cardWidth;
  const SimilarRecipesWidget({
    required this.similarRecipesList,
    required this.recipeId,
    required this.searchForSimilarRecipes,
    required this.cardWidth,
    super.key,
  });
  @override
  State<SimilarRecipesWidget> createState() => _SimilarRecipesState();
}

class _SimilarRecipesState extends State<SimilarRecipesWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;

    CarouselController carouselController = CarouselController(
      initialItem: (widget.similarRecipesList?.length ?? 2) ~/ 2,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.similarRecipesList == null && _isLoading == false)
          // Search For Similar Recipes Button
          DottedBorder(
            padding: const EdgeInsets.symmetric(vertical: 75, horizontal: 100),
            dashPattern: const [6, 10],
            color: Theme.of(context).colorScheme.outlineVariant,
            strokeWidth: 2,
            strokeCap: StrokeCap.round,
            child: OutlinedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                await widget.searchForSimilarRecipes();
                setState(() {
                  _isLoading = false;
                });
              },
              child: const Text('Find Similar Recipes'),
            ),
          ),

        // Carousel
        if (widget.similarRecipesList != null || _isLoading)
          Container(
            constraints: BoxConstraints(maxHeight: height / 4.0),
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    //Theme.of(context).colorScheme.surface,
                    Colors.transparent,
                    Colors.black,
                    Colors.black,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.1, 0.90, 1],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: CarouselView.weighted(
                controller: carouselController,
                shrinkExtent: 500,
                backgroundColor: Colors.transparent,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                padding: EdgeInsets.all(9),
                itemSnapping: true,
                flexWeights: const <int>[2, 3, 2],
                children: widget.similarRecipesList != null
                    ? widget.similarRecipesList!
                        .map((SimilarRecipeModel recipe) {
                        return RecipeDisplayCardWidget(
                            expand: true,
                            imageUrl: recipe.imageUrl!,
                            title: recipe.title!,
                            recipeId: recipe.recipeId!,
                            cardWidth: widget.cardWidth);
                      }).toList()
                    : List.generate(
                        5,
                        (index) =>
                            _ShimmeringRecipeCard(cardWidth: widget.cardWidth),
                      ),
              ),
            ),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _ShimmeringRecipeCard extends StatelessWidget {
  final double cardWidth;
  const _ShimmeringRecipeCard({required this.cardWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      child: Card(
        margin: EdgeInsets.all(0),
        color: Theme.of(context).colorScheme.onSecondary,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade600,
          highlightColor: Colors.grey.shade300,
          child: Column(
            children: [
              Container(
                width: cardWidth,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 9,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 13),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 9,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 13),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 50),
                child: Container(
                  height: 9,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
