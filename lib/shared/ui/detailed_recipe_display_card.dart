import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:recipe_box/shared/models/recipe.dart';

class DetailedRecipeDisplayCard extends StatelessWidget {
  final Recipe recipe;
  final bool showPopularBadge;
  final int recipeListIndex;
  const DetailedRecipeDisplayCard({
    required this.recipe,
    required this.showPopularBadge,
    required this.recipeListIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "$recipeListIndex Card",
      child: SizedBox(
        width: 185,
        child: GestureDetector(
          onTap: () {
            final Map<String, dynamic> arguments = {
              "recipeListIndex": recipeListIndex,
              "imageUrl": recipe.imageUrl,
              "title": recipe.title,
            };
            Navigator.pushNamed(
              context,
              '/searchPage/searchResults/recipe',
              arguments: arguments,
            );
          },
          child: Card(
            margin: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
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
                  recipeListIndex: recipeListIndex,
                ),
                const SizedBox(height: 3),
                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: AutoSizeText(
                    recipe.title,
                    style: Theme.of(context).textTheme.titleSmall!,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(),
                Text(
                  'Per Serving:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    letterSpacing: 0.5,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 7),

                _NumbersTextRichText(
                    start: recipe.calories.toString(),
                    end: (recipe.calories > 1) ? ' Calories' : ' Calorie'),
                _NumbersTextRichText(
                    start: '${recipe.protein}g', end: ' of Protein'),
                _NumbersTextRichText(start: '${recipe.fat}g', end: ' of Fat'),

                const SizedBox(height: 10),
              ],
            ),
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
  final int recipeListIndex;

  const _RecipeImage({
    required this.imageUrl,
    required this.time,
    required this.popular,
    required this.showPopularBadge,
    required this.recipeListIndex,
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
      borderRadius: BorderRadius.circular(20),
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
            //if (popular == true && showPopularBadge == true) ...[
            //  Padding(
            //    padding: const EdgeInsets.only(left: 120),
            //    child: badges.Badge(
            //      position: badges.BadgePosition.topEnd(end: 52),
            //      stackFit: StackFit.expand,
            //      badgeStyle: const badges.BadgeStyle(
            //        shape: badges.BadgeShape.instagram,
            //        badgeGradient: badges.BadgeGradient.linear(
            //          colors: [Colors.deepPurpleAccent, Colors.redAccent],
            //          begin: Alignment.topRight,
            //          end: Alignment.bottomLeft,
            //        ),
            //      ),
            //      badgeContent: const SizedBox(
            //        width: 45,
            //        height: 45,
            //        child: Center(
            //          child: Text(
            //            'POPULAR',
            //            style: TextStyle(
            //                fontSize: 7,
            //                fontWeight: FontWeight.bold,
            //                height: 0.5),
            //            textAlign: TextAlign.center,
            //          ),
            //        ),
            //      ),
            //    ),
            //  ),
            //],
          ],
        ),
      ),
    );
  }
}

class _NumbersTextRichText extends StatelessWidget {
  final String start;
  final String end;
  const _NumbersTextRichText({
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize = 15;
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5, top: 1.5),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            // Numbers
            TextSpan(
              text: start,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),

            TextSpan(
              text: end,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
