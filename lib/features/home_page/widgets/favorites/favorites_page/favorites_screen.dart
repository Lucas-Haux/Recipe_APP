import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/shared/ui/back_search_home_bar.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/ui/detailed_recipe_display_card.dart';
import 'package:recipe_box/shared/ui/recipe_search_bar.dart';

class FavoritesScreen extends ConsumerWidget {
  final List<Recipe> favorites;
  const FavoritesScreen({required this.favorites, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Recipe> leftFavorites = [];
    final List<Recipe> rightFavorites = [];

    int index = 0;
    for (Recipe favorite in favorites) {
      index++;
      if (index.isEven) {
        leftFavorites.add(favorite);
      } else if (index.isOdd) {
        rightFavorites.add(favorite);
      }
    }

    // Backgroud gradient
    return Container(
      decoration: BoxDecoration(
        gradient: SweepGradient(
          colors: [
            Color(0XFF8b0000),
            //.withAlpha(120),
            Colors.transparent,
          ],
          endAngle: 10,
          center: Alignment.bottomLeft,
          stops: [0.3, 0.8],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            forceMaterialTransparency: true,
            leadingWidth: 0,
            titleSpacing: 0,
            leading: const SizedBox.shrink(),
            title: BackSearchHomeBar(key: Key('favorites'), backButton: false),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 15),
              TextAnimator(
                'Favorites',
                atRestEffect: WidgetRestingEffects.wave(
                  duration: Duration(milliseconds: 2500),
                ),
                textAlign: TextAlign.center,
                initialDelay: const Duration(milliseconds: 50),
                spaceDelay: const Duration(milliseconds: 65),
                characterDelay: const Duration(milliseconds: 65),
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  shadows: [
                    Shadow(
                        blurRadius: 9,
                        color: Colors.white.withAlpha(70),
                        offset: Offset(-3, -3)),
                    Shadow(
                        blurRadius: 9,
                        color: Colors.white.withAlpha(70),
                        offset: Offset(3, -3)),
                    Shadow(
                        blurRadius: 9,
                        color: Colors.white.withAlpha(70),
                        offset: Offset(-3, 3)),
                    Shadow(
                        blurRadius: 9,
                        color: Colors.white.withAlpha(70),
                        offset: Offset(3, 3)),
                  ],
                ),
              ),
              SizedBox(height: 15),

              // Recipes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      leftFavorites.length,
                      (int index) => Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 5,
                          bottom: 10,
                        ),
                        child: DetailedRecipeDisplayCard(
                          key: Key(
                              '${leftFavorites[index].recipeId.toString()}DRDC'),
                          recipe: leftFavorites[index],
                          showPopularBadge: false,
                          recipeListIndex: index,
                        ),
                      ),
                    ),
                  ),

                  // Right Side
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      rightFavorites.length,
                      (int index) => Padding(
                        padding: EdgeInsets.only(
                          left: 5,
                          right: 10,
                          bottom: 10,
                        ),
                        child: DetailedRecipeDisplayCard(
                          key: Key(
                              '${rightFavorites[index].recipeId.toString()}DRDC'),
                          recipe: rightFavorites[index],
                          showPopularBadge: false,
                          recipeListIndex: index,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
