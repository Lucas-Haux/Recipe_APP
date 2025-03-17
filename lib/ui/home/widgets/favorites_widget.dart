import 'package:flutter/material.dart';
import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:recipe_box/ui/core/ui/recipe_display_card_widget.dart';

class FavoritesWidget extends StatelessWidget {
  final double height;
  final List<RecipeModel> favoritesList;
  const FavoritesWidget({
    required this.height,
    required this.favoritesList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController =
        CarouselController(initialItem: favoritesList.length ~/ 2);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        gradient: LinearGradient(
          colors: [
            Color(0XFF8b0000).withAlpha(100),
            Colors.transparent,
          ],
          stops: [0.30, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // Title
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Row(
              spacing: 7,
              children: [
                Icon(
                  Icons.favorite_outline_rounded,
                  size: 30,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Favorites\n',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: '#${favoritesList.length}', // Subtext
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    Icons.expand_more_rounded,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),

          // Carousel
          Container(
            constraints: BoxConstraints(maxHeight: height / 5),
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
                  stops: [0.0, 0.04, 0.96, 1],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,

              // carousel
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
                flexWeights: const <int>[3, 4, 3],
                children: favoritesList.map((RecipeModel recipe) {
                  return RecipeDisplayCardWidget(
                    expand: true,
                    title: recipe.title,
                    titleStyle: TextStyle(fontWeight: FontWeight.bold),
                    imageUrl: recipe.imageUrl,
                    recipeId: recipe.recipeId,
                    cardWidth: 350,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
