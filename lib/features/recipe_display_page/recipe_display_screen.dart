import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipe_box/features/recipe_display_page/recipe_display_manager.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/enum_row_display.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/equipment_card.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/ingredents_card.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/instructions_card.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/misc_info.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/servings_info.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/similar_recipes_card.dart';
import 'package:recipe_box/shared/themes/dimens.dart';
import 'package:recipe_box/shared/ui/back_search_home_bar.dart';
import 'package:recipe_box/shared/ui/basic_recipe_display_card.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

double cardWidth = 371;

TextEditingController searchController = TextEditingController();

class RecipeDisplayScreen extends ConsumerWidget {
  final dynamic database;
  final String recipeTitle;
  final String recipeImageUrl;
  final int id;
  const RecipeDisplayScreen({
    required this.database,
    required this.id,
    required this.recipeTitle,
    required this.recipeImageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager =
        ref.watch(recipeDisplayManagerProvider(database, id).notifier);

    final recipe = ref.watch(recipeDisplayManagerProvider(database, id)).value;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        titleSpacing: 0,
        leading: const SizedBox(), // Remove Default Back Button
        forceMaterialTransparency: true,
        title: const BackSearchHomeBar(
          backButton: true,
          homeButton: true,
        ),
      ),
      body: Hero(
        tag: "${id}Card",
        child: SingleChildScrollView(
          padding: Dimens.of(context).edgeInsetsScreenHorizontal,
          child: Column(
            children: [
              BasicRecipeDisplayCard(
                expand: false,
                recipe: recipe,
                imageUrl: (recipe != null) ? recipe.imageUrl : recipeImageUrl,
                title: (recipe != null) ? recipe.title : recipeTitle,
                id: (recipe != null) ? recipe.id : id,
                cardWidth: cardWidth,
                titleStyle: Theme.of(context).textTheme.titleMedium!,
              ),
              const SizedBox(height: 3),
              if (recipe != null) ...[
                //Diets
                if (recipe.diets.isNotEmpty && recipe.diets[0].isNotEmpty)
                  EnumRowDisplay(
                    listEnum: recipe.diets,
                    cardWidth: cardWidth,
                    key: Key('${recipe.title} diets'),
                  ),

                // Row of Serving and misc cards
                SizedBox(
                  width: cardWidth,
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServingsInfoCard(
                        cardWidth: cardWidth,
                        servings: recipe.servings,
                        calories: recipe.calories,
                        fat: recipe.fat,
                        protein: recipe.protein,
                        pricePerServing: recipe.pricePerServing,
                      ),
                      MicInfoCard(
                        cardWidth: cardWidth,
                        sourceUrl: recipe.sourceUrl,
                        sourceName: recipe.sourceName,
                        time: recipe.time,
                        ingredients: recipe.ingredients,
                        weightWatcher: recipe.weightWatcher,
                        healthScore: recipe.healthScore,
                        nutrients: recipe.nutrients,
                      )
                    ],
                  ),
                ),

                // Cuisines
                if (recipe.cuisines.isNotEmpty && recipe.cuisines[0].isNotEmpty)
                  EnumRowDisplay(
                      listEnum: recipe.cuisines,
                      cardWidth: cardWidth,
                      key: Key('${recipe.title} cuisines')),

                // Dish Types
                if (recipe.dishTypes.isNotEmpty &&
                    recipe.dishTypes[0].isNotEmpty)
                  EnumRowDisplay(
                    listEnum: recipe.dishTypes,
                    cardWidth: cardWidth,
                    key: Key('${recipe.title} dishTypes'),
                  ),

                // Seperation
                const SizedBox(height: 20),
                const Divider(),

                EquipmentCard(
                  cardWidth: cardWidth,
                  instructions: recipe.instructions,
                  key: Key('${recipe.title} equipment'),
                ),
                IngredentsCard(
                  cardWidth: cardWidth,
                  ingredients: recipe.ingredients,
                  key: Key('${recipe.title} ingredents'),
                ),

                // Seperation
                const SizedBox(height: 20),
                const Divider(),

                InstructionsCard(
                  getParagraphDataForRecipe: manager.getMissingDataForRecipe,
                  instructions: recipe.instructions,
                  cardWidth: cardWidth,
                  instructionsParagraph: recipe.instructionsParagraph,
                ),

                if (database != null) ...[
                  //Seperation
                  const SizedBox(height: 20),
                  const Divider(),

                  TextAnimator(
                    'Similar Recipes',
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

                  SimilarRecipesCard(
                    recipe: recipe,
                    //id: recipe.id!,
                    database: database,
                    cardWidth: cardWidth,
                    //similarRecipesList: recipe.similarRecipes,
                    //searchForSimilarRecipes: manager.searchSimilarRecipes,
                  ),
                ],
                const SizedBox(height: 15)
              ],
            ],
          ),
        ),
      ),
    );
  }
}
