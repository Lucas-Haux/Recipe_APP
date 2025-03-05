import 'package:flutter/material.dart';
import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:recipe_box/ui/core/ui/recipe_image_widget.dart';

class RecipeDisplayCardWidget extends StatelessWidget {
  final int? recipeId;
  final String title;
  final String imageUrl;
  final double? height;
  final double cardWidth;
  final TextStyle? titleStyle;
  const RecipeDisplayCardWidget({
    required this.title,
    this.recipeId,
    required this.imageUrl,
    this.titleStyle,
    required this.cardWidth,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO
        throw UnimplementedError("Similar Recipe Card Tap");
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: SizedBox(
          width: cardWidth,
          child: Card(
            color: Theme.of(context).colorScheme.onSecondary,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Image
                RecipeImageWidget(
                  imageUrl: imageUrl,
                  cardWidth: cardWidth,
                ),

                //Spacer(),

                // Title
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: titleStyle,
                    maxLines: 3,
                  ),
                ),

                // Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
