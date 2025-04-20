import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/ui/recipe_image_manager.dart';

class RecipeImage extends ConsumerWidget {
  final String imageUrl;
  final Recipe? recipe;
  final double cardWidth;
  final double? height;
  const RecipeImage({
    this.recipe,
    required this.imageUrl,
    required this.cardWidth,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final manager =
    //ref.watch(recipeFavoritesViewmodelProvider(recipe).notifier);
    final manager = ref.watch(recipeImageManagerProvider(recipe).notifier);

    final bool? isFavorite =
        ref.watch(recipeImageManagerProvider(recipe)).value;
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(10), bottom: Radius.circular(20)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Image
          // TODO need to cache the image
          Image.network(
            imageUrl,
            width: cardWidth,
            height: height,
          ),

          // favorites button
          if (isFavorite != null)
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  if (isFavorite) {
                    manager.removeFavorite();
                  } else {
                    manager.addFavorite();
                  }
                },
                color: Colors.redAccent,
                icon: const Icon(
                  Icons.favorite_outline,
                  size: 35,
                ),
                selectedIcon: const Icon(
                  Icons.favorite,
                  size: 35,
                ),
                isSelected: isFavorite,
              ),
            ),
        ],
      ),
    );
  }
}
