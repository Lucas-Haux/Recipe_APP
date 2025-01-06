import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:recipe_box/data/repositories/recipe_data_repository.dart';
import 'package:recipe_box/domain/models/similar_recipe_model.dart';

import 'widgets/recipe_image_widget.dart';
import 'widgets/equipment_card_widget.dart';
import 'widgets/ingredents_card_widget.dart';
import 'widgets/row_of_data_card_widget.dart';
import 'widgets/dual_recipe_cards_widget.dart';
import 'widgets/instructions_card_widget.dart';

import 'recipe_viewmodel.dart';

import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:recipe_box/ui/core/ui/search_bar_field_widget.dart';

double cardWidth = 370;

const TextStyle _titleStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

class RecipeScreen extends ConsumerWidget {
  final int recipeListIndex;
  const RecipeScreen({required this.recipeListIndex, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RecipeViewmodel viewModel =
        ref.watch(recipeViewModelProvider(recipeListIndex));
    RecipeModel recipe = viewModel.recipe(recipeListIndex);

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
            FilledButton(
                onPressed: () {
                  print(recipe.instructionsParagraph);
                },
                child: Text('test')),
            // Image and Title Card
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
                key: Key('${recipe.title} dualCards')),

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
              getParagraphDataForRecipe: viewModel.getParagraphDataForRecipe,
              instructions: recipe.instructions,
              cardWidth: cardWidth,
              titleStyle: _titleStyle,
              id: recipe.id,
              // TODO use view model
              instructionsParagraph: ref
                  .watch(recipeDataRepositoryProvider)[recipeListIndex]
                  .instructionsParagraph,
            ),

            // Seperation
            const SizedBox(height: 20),
            const Divider(),

            _SimilarRecipes(id: recipe.id),
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
            onPressed: () => context.pop(),
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
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: SearchBarFieldWidget(
                  goToSearchPage: true,
                  controller: TextEditingController(),
                  onTap: () {
                    context.go('/search');
                  },
                ),
              ),
            ),
          ),

          const Spacer(),

          // Home Button
          Hero(
            tag: const Key('HomeButton'),
            child: IconButton(
              onPressed: () => context.go('/'),
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

class _SimilarRecipes extends StatefulWidget {
  final int id;
  const _SimilarRecipes({required this.id});

  @override
  State<_SimilarRecipes> createState() => _SimilarRecipesState();
}

class _SimilarRecipesState extends State<_SimilarRecipes> {
  List<SimilarRecipeModel> similarRecipes = [];

  final PageController carouselController =
      PageController(initialPage: 1, viewportFraction: 1 / 2);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Column(
          children: [
            if (similarRecipes.isEmpty)
              FilledButton(
                onPressed: () async {
                  // final newList =
                  //    await RecipeViewmodel().searchSimilarRecipes(widget.id);
                  setState(() {
                    // similarRecipes = newList;
                  });
                },
                child: const Text('Find Similar Recipes'),
              ),

            // Carousel
            if (similarRecipes.isNotEmpty)
              ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: 300, maxWidth: cardWidth),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.1, 0.9, 1],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: PageView.builder(
                    controller: carouselController,
                    pageSnapping: false,
                    dragStartBehavior: DragStartBehavior.start,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    allowImplicitScrolling: true,
                    itemCount: similarRecipes.length,
                    itemBuilder: (context, index) {
                      return _SimilarRecipeCard(recipe: similarRecipes[index]);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SimilarRecipeCard extends StatelessWidget {
  final SimilarRecipeModel recipe;
  const _SimilarRecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RecipeImage(
                imageUrl: recipe.imageUrl,
                favoriteButton: false,
                cardWidth: cardWidth,
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(recipe.title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
