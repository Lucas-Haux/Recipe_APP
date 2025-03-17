import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:recipe_box/ui/core/ui/recipe_display_card_widget.dart';
import 'package:recipe_box/ui/core/ui/recipe_image_widget.dart';

import 'widgets/equipment_card_widget.dart';
import 'widgets/ingredents_card_widget.dart';
import 'widgets/row_of_data_card_widget.dart';
import 'widgets/dual_recipe_cards_widget.dart';
import 'widgets/instructions_card_widget.dart';
import 'widgets/similar_recipes_widget.dart';

import 'recipe_viewmodel.dart';

import 'package:recipe_box/ui/core/ui/search_bar_field_widget.dart';

double cardWidth = 371;

TextEditingController searchController = TextEditingController();

const TextStyle _titleStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

class RecipeScreen extends ConsumerWidget {
  final int recipeListIndex;
  final String title;
  final String imageUrl;
  const RecipeScreen({
    required this.recipeListIndex,
    required this.title,
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel =
        ref.watch(recipeViewmodelProvider(recipeListIndex).notifier);
    final theState = ref.watch(recipeViewmodelProvider(recipeListIndex));

    while (theState.valueOrNull == null) {
      return Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          titleSpacing: 0,
          leading: const SizedBox(), // Remove Default Back Button
          forceMaterialTransparency: true,
          title: const _AppBar(),
        ),
        body: Hero(
          tag: "$recipeListIndex Card",
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RecipeDisplayCardWidget(
                  expand: false,
                  title: title,
                  imageUrl: imageUrl,
                  cardWidth: cardWidth,
                  titleStyle: _titleStyle,
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
    final recipe = ref.watch(recipeViewmodelProvider(recipeListIndex)).value!;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        titleSpacing: 0,
        leading: const SizedBox(), // Remove Default Back Button
        forceMaterialTransparency: true,
        title: const _AppBar(),
      ),
      body: Hero(
        tag: "$recipeListIndex Card",
        child: SingleChildScrollView(
          child: Column(
            children: [
              RecipeDisplayCardWidget(
                expand: false,
                recipe: recipe,
                imageUrl: recipe.imageUrl,
                title: recipe.title,
                recipeId: recipe.recipeId,
                cardWidth: cardWidth,
                titleStyle: _titleStyle,
              ),

              // Diets
              if (recipe.diets.isNotEmpty && recipe.diets[0].isNotEmpty)
                RowOfDataCard(
                  listEnum: recipe.diets,
                  cardWidth: cardWidth,
                  key: Key('${recipe.title} diets'),
                ),

              // Row of Serving and misc cards
              DualRecipeCards(
                cardWidth: cardWidth,
                recipe: recipe,
                key: Key('${recipe.title} dualCards'),
              ),

              // Cuisines
              if (recipe.cuisines.isNotEmpty && recipe.cuisines[0].isNotEmpty)
                RowOfDataCard(
                    listEnum: recipe.cuisines,
                    cardWidth: cardWidth,
                    key: Key('${recipe.title} cuisines')),

              // Dish Types
              if (recipe.dishTypes.isNotEmpty && recipe.dishTypes[0].isNotEmpty)
                RowOfDataCard(
                  listEnum: recipe.dishTypes,
                  cardWidth: cardWidth,
                  key: Key('${recipe.title} dishTypes'),
                ),

              // Seperation
              const SizedBox(height: 20),
              const Divider(),

              EquipmentCard(
                cardWidth: cardWidth,
                titleStyle: _titleStyle,
                instructions: recipe.instructions,
                key: Key('${recipe.title} equipment'),
              ),
              IngredentsCard(
                cardWidth: cardWidth,
                titleStyle: _titleStyle,
                ingredients: recipe.ingredients,
                key: Key('${recipe.title} ingredents'),
              ),

              // Seperation
              const SizedBox(height: 20),
              const Divider(),

              InstructionCard(
                getParagraphDataForRecipe: viewModel.getMissingDataForRecipe,
                instructions: recipe.instructions,
                cardWidth: cardWidth,
                titleStyle: _titleStyle,
                // TODO use view model
                instructionsParagraph: recipe.instructionsParagraph,
              ),

              // Seperation
              const SizedBox(height: 20),
              const Divider(),

              SimilarRecipesWidget(
                id: recipe.id!,
                cardWidth: cardWidth,
                givenSimilarRecipes: recipe.similarRecipes,
                searchForSimilarRecipes: viewModel.searchSimilarRecipes,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),

          // Back Button
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          const Spacer(),

          // Search Button
          SizedBox(
            height: 45,
            width: 250,
            child: Hero(
              tag: 'SearchBar',
              child: SearchBarFieldWidget(
                key: const ValueKey('SearchBar'),
                searchPage: false,
                controller: searchController,
              ),
            ),
          ),

          const Spacer(),

          // Home Button
          Hero(
            tag: const Key('HomeButton'),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, '/'),
              icon: Icon(
                Icons.home,
                size: 30,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),

          const Spacer()
        ],
      ),
    );
  }
}
