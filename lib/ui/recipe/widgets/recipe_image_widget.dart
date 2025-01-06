import 'package:flutter/material.dart';

class RecipeImage extends StatelessWidget {
  final String imageUrl;
  final bool favoriteButton;
  final double cardWidth;
  const RecipeImage({
    required this.imageUrl,
    required this.favoriteButton,
    required this.cardWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.network(
            imageUrl,
            width: cardWidth,
          ),
          // favorites button
          if (favoriteButton == true)
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  print('favorite button pressed');
                  // change favorite state of recipe id
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
                isSelected:
                    false, // need to change to favorite state of recipe id
              ),
            ),
        ],
      ),
    );
  }
}
