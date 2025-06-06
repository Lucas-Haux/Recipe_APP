import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/ui/basic_recipe_display_card.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class FavoritesCard extends StatelessWidget {
  final double height;
  final List<Recipe>? favoritesList;
  const FavoritesCard({
    required this.height,
    required this.favoritesList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController(
      initialItem: (favoritesList == null) ? favoritesList!.length ~/ 2 : 1,
    );
    final Color primaryColor = Colors.white;

    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        gradient: LinearGradient(
          colors: [
            Color(0XFF8b0000).withAlpha(100),
            Colors.transparent,
          ],
          stops: [0.30, 0.999],
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
                  color: primaryColor,
                  size: 30,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Favorites\n',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: primaryColor),
                    children: [
                      TextSpan(
                        text: '#${favoritesList?.length ?? 0}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.redAccent,
                          height: 0.7,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Forword button
                if (favoritesList!.isNotEmpty && favoritesList != null)
                  IconButton(
                    onPressed: () {
                      if (favoritesList != null && favoritesList!.isNotEmpty) {
                        Navigator.pushNamed(
                          context,
                          '/favorites',
                          arguments: favoritesList,
                        );
                      }
                    },
                    icon: Icon(
                      Symbols.chevron_right_rounded,
                      color: primaryColor,
                      weight: 400,
                      size: 45,
                    ),
                  ),
              ],
            ),
          ),

          Container(
            constraints: BoxConstraints(maxHeight: height / 5),
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                    Colors.black,
                    Colors.transparent,
                  ],
                  stops: [0.02, 0.25, 0.75, 0.98],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,

              // carousel
              child: (favoritesList != null && favoritesList!.isNotEmpty)
                  ? CarouselView(
                      controller: carouselController,
                      shrinkExtent: 123.8,
                      itemExtent: 123.8,
                      backgroundColor: Colors.transparent,
                      elevation: 10,
                      onTap: (int index) {
                        final recipe = favoritesList![index];
                        final Map<String, dynamic> arguments = {
                          'recipeTitle': recipe.title,
                          'id': recipe.id,
                          'recipeImageUrl': recipe.imageUrl
                        };
                        Navigator.pushNamed(
                          context,
                          '/recipe',
                          arguments: arguments,
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      padding: EdgeInsets.all(9),
                      itemSnapping: true,
                      children: favoritesList!.map((Recipe recipe) {
                        return Hero(
                          tag: '${recipe.id}Card',
                          placeholderBuilder: (context, size, child) {
                            return Container(
                              width: size.width,
                              height: size.height,
                              color: Theme.of(context).colorScheme.surface,
                            );
                          },
                          child: BasicRecipeDisplayCard(
                            key: Key('${recipe.id}Card'),
                            expand: true,
                            title: recipe.title,
                            titleStyle: TextStyle(fontWeight: FontWeight.bold),
                            imageUrl: recipe.imageUrl,
                            id: recipe.id,
                            cardWidth: 123.8,
                          ),
                        );
                      }).toList(),
                    )
                  // Display when no data
                  : Column(
                      spacing: 8,
                      children: [
                        WidgetAnimator(
                          incomingEffect:
                              WidgetTransitionEffects.incomingScaleUp(
                            delay: Duration(seconds: 1),
                            duration: Duration(seconds: 1),
                          ),
                          child: Text(
                            'No Favorites Found',
                            style: Theme.of(context).textTheme.titleMedium!,
                          ),
                        ),
                        // Empty box animation
                        SizedBox(
                          height: 140,
                          width: 250,
                          child: Transform.scale(
                            scale: 1.8,
                            child: Lottie.asset(
                              'assets/lottie_favorites_animation.json',
                              repeat: false,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
