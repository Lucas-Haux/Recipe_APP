import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'widgets/recipe_image_widget.dart';
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
  const RecipeScreen({required this.recipeListIndex, super.key});

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
        body: Center(
          child: CircularProgressIndicator(),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: cardWidth,
              child: Card(
                color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                child: Column(
                  children: [
                    // Image
                    RecipeImage(
                      imageUrl: recipe.imageUrl,
                      favoriteButton: true,
                      cardWidth: cardWidth,
                      key: Key('${recipe.title} image'),
                    ),
                    // Title
                    Text(
                      recipe.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: _titleStyle,
                    ),
                  ],
                ),
              ),
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
