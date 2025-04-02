import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipe_box/features/recipe_display_page/recipe_display_search_manager.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/enum_row_display.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/equipment_card.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/ingredents_card.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/instructions_card.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/misc_info.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/servings_info.dart';
import 'package:recipe_box/features/recipe_display_page/widgets/similar_recipes_card.dart';
import 'package:recipe_box/shared/ui/back_search_home_bar.dart';
import 'package:recipe_box/shared/ui/basic_recipe_display_card.dart';

double cardWidth = 371;

TextEditingController searchController = TextEditingController();

class RecipeDisplayScreen extends ConsumerWidget {
  final String recipeTitle;
  final String recipeImageUrl;
  final int recipeId;
  const RecipeDisplayScreen({
    required this.recipeId,
    required this.recipeTitle,
    required this.recipeImageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ModalRoute.of(context)!.settings.name!;

    final manager =
        ref.watch(recipeDisplayManagerProvider(route, recipeId).notifier);
    final theState = ref.watch(recipeDisplayManagerProvider(route, recipeId));
    final recipe =
        ref.watch(recipeDisplayManagerProvider(route, recipeId)).value;

    while (theState.valueOrNull == null) {
      return Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          titleSpacing: 0,
          leading: const SizedBox(), // Remove Default Back Button
          forceMaterialTransparency: true,
          title: const BackSearchHomeBar(backButton: true),
        ),
        body: Hero(
          tag: "$recipeListIndex Card",
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BasicRecipeDisplayCard(
                  expand: false,
                  title: recipeTitle,
                  imageUrl: recipeImageUrl,
                  cardWidth: cardWidth,
                  titleStyle: Theme.of(context).textTheme.titleMedium!,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 5),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                SizedBox(height: 50, width: MediaQuery.of(context).size.width),
              ],
            ),
          ),
        ),
      );
    }

    if (recipe != null)
      return Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          titleSpacing: 0,
          leading: const SizedBox(), // Remove Default Back Button
          forceMaterialTransparency: true,
          title: const BackSearchHomeBar(backButton: true),
        ),
        body: Hero(
          tag: "$recipeListIndex Card",
          child: SingleChildScrollView(
            child: Column(
              children: [
                BasicRecipeDisplayCard(
                  expand: false,
                  recipe: recipe,
                  imageUrl: recipe.imageUrl,
                  title: recipe.title,
                  recipeId: recipe.recipeId,
                  cardWidth: cardWidth,
                  titleStyle: Theme.of(context).textTheme.titleMedium!,
                ),

                const SizedBox(height: 3),

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

                //Seperation
                const SizedBox(height: 20),
                const Divider(),

                SimilarRecipesCard(
                  recipeId: recipe.id!,
                  cardWidth: cardWidth,
                  similarRecipesList: recipe.similarRecipes,
                  searchForSimilarRecipes: manager.searchSimilarRecipes,
                ),
              ],
            ),
          ),
        ),
      );

    return Placeholder();
  }
}
