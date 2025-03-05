import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:recipe_box/ui/recipe/recipe_favorites_viewmodel.dart';

class RecipeImageWidget extends ConsumerWidget {
  final String imageUrl;
  final RecipeModel? recipe;
  final double cardWidth;
  const RecipeImageWidget({
    this.recipe,
    required this.imageUrl,
    required this.cardWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel =
        ref.watch(recipeFavoritesViewmodelProvider(recipe).notifier);
    final isFavorite =
        ref.watch(recipeFavoritesViewmodelProvider(recipe)).value;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Image
          // TODO need to cache the image
          Image.network(
            imageUrl,
            width: cardWidth,
          ),

          // favorites button
          if (isFavorite != null)
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  if (isFavorite) {
                    viewModel.removeFavorite();
                  } else {
                    viewModel.addFavorite();
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
