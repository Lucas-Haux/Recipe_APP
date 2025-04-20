import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/ui/recipe_image.dart';

class BasicRecipeDisplayCard extends StatelessWidget {
  final int? id;
  final Recipe? recipe;
  final String title;
  final String imageUrl;
  final bool expand;
  final double cardWidth;
  final double? height;
  final TextStyle? titleStyle;
  const BasicRecipeDisplayCard({
    this.recipe,
    required this.title,
    this.id,
    required this.imageUrl,
    this.titleStyle,
    required this.cardWidth,
    this.height,
    required this.expand,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      child: Card(
        margin: EdgeInsets.all(0),
        color: Theme.of(context).colorScheme.onSecondary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Image
            RecipeImage(
              key: Key('${recipe?.id}Image'),
              recipe: recipe,
              imageUrl: imageUrl,
              cardWidth: cardWidth,
              height: height,
            ),

            //Spacer(),

            // Title
            if (expand == true)
              Expanded(
                child: Center(
                  child: AutoSizeText(
                    title,
                    minFontSize: 0.1,
                    maxFontSize: 20,
                    stepGranularity: 0.1,
                    textAlign: TextAlign.center,
                    style: titleStyle,
                    //maxLines: 3,
                  ),
                ),
              ),
            if (expand != true)
              Padding(
                padding: EdgeInsets.all(5),
                child: AutoSizeText(
                  title,
                  minFontSize: 0.1,
                  maxFontSize: 25,
                  stepGranularity: 0.1,
                  textAlign: TextAlign.center,
                  style: titleStyle,
                  //maxLines: 3,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
