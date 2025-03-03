import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:go_router/go_router.dart';

import '../../../domain/models/recipe_model.dart';

class RecipeDisplayCard extends StatelessWidget {
  final RecipeModel recipe;
  final bool showPopularBadge;
  final int recipeListIndex;
  const RecipeDisplayCard({
    required this.recipe,
    required this.showPopularBadge,
    required this.recipeListIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 185,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/searchPage/searchResults/recipe',
            arguments: recipeListIndex,
          );
        },
        child: Card(
          margin: const EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _RecipeImage(
                imageUrl: recipe.imageUrl,
                time: recipe.time,
                popular: recipe.popular,
                showPopularBadge: showPopularBadge,
              ),
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  recipe.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(),
              const Text(
                'Per Serving:',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 7),
              Text(
                recipe.calories,
                textAlign: TextAlign.center,
              ),
              Text(
                recipe.protein,
                textAlign: TextAlign.center,
              ),
              Text(
                recipe.fat,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipeImage extends StatelessWidget {
  final String imageUrl;
  final int time;
  final bool popular;
  final bool showPopularBadge;
  const _RecipeImage({
    required this.imageUrl,
    required this.time,
    required this.popular,
    required this.showPopularBadge,
  });

  @override
  Widget build(BuildContext context) {
    String newTime = '';
    if (time >= 61) {
      double hour = time / 60;
      double min = time % 60;

      newTime = '${hour.round()}h:${min.round()}m';
    } else {
      newTime = '${time}m';
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        width: 175,
        child: Stack(
          children: [
            // Picture
            Image.network(imageUrl),

            // Time Banner
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.4), // Shadow color with opacity
                    spreadRadius: 1, // How far the shadow spreads
                    blurRadius: 5, // How soft the shadow appears
                    offset:
                        const Offset(2, 2), // Horizontal and vertical offset
                  ),
                ],
              ),
              padding:
                  const EdgeInsets.only(left: 6, right: 8, bottom: 8, top: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    newTime,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Popular Badge
            if (popular == true && showPopularBadge == true) ...[
              Padding(
                padding: const EdgeInsets.only(left: 120),
                child: badges.Badge(
                  position: badges.BadgePosition.topEnd(end: 52),
                  stackFit: StackFit.expand,
                  badgeStyle: const badges.BadgeStyle(
                    shape: badges.BadgeShape.instagram,
                    badgeGradient: badges.BadgeGradient.linear(
                      colors: [Colors.deepPurpleAccent, Colors.redAccent],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  badgeContent: const SizedBox(
                    width: 45,
                    height: 45,
                    child: Center(
                      child: Text(
                        'POPULAR',
                        style: TextStyle(
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                            height: 0.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
