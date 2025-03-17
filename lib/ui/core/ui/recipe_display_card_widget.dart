import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:recipe_box/ui/core/ui/recipe_image_widget.dart';

class RecipeDisplayCardWidget extends StatelessWidget {
  final RecipeModel? recipe;
  final int? recipeId;
  final String title;
  final String imageUrl;
  final bool expand;
  final double cardWidth;
  final TextStyle? titleStyle;
  const RecipeDisplayCardWidget({
    this.recipe,
    required this.title,
    this.recipeId,
    required this.imageUrl,
    this.titleStyle,
    required this.cardWidth,
    required this.expand,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO
        throw UnimplementedError("Similar Recipe Card Tap");
      },
      child: SizedBox(
        width: cardWidth,
        child: Card(
          margin: EdgeInsets.all(0),
          color: Theme.of(context).colorScheme.onSecondary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Image
              RecipeImageWidget(
                recipe: recipe,
                imageUrl: imageUrl,
                cardWidth: cardWidth,
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
                    maxFontSize: 20,
                    stepGranularity: 0.1,
                    textAlign: TextAlign.center,
                    style: titleStyle,
                    //maxLines: 3,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
