import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/databases/recipe_favorites/recipe_favorites_database.dart';
import 'package:recipe_box/shared/databases/recipe_search_results/recipe_search_results_database.dart';
import 'package:recipe_box/shared/services/remote/recipe_data.dart';
import 'package:recipe_box/shared/services/remote/similar_recipes.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_display_manager.g.dart';

final recipeListIndex = 1;

@riverpod
class RecipeDisplayManager extends _$RecipeDisplayManager {
  @override
  Future<Recipe> build(dynamic database, int id) async {
    try {
      print('database: ${database.toString()}');
      // get the _recipe data
      if (database != null) {
        _recipe = await ref.watch(database).getSingleRecipe(id)!;
      } else {
        final result = await RecipeData().fetchFullRecipe(id);
        _recipe = Recipe.fromJson(result);
      }

      isFavoirte = await ref
          .watch(favoritesDatabaseProvider)
          .checkIfRecipeIsFavorite(_recipe!.id);

      return _recipe!;
    } catch (e) {
      throw "Failed to build recipe display manager: $e";
    }
  }

  late Recipe? _recipe;
  late bool isFavoirte;

  // api call to get similar recipes by id
  Future<AsyncValue<List<SimilarRecipe>>> searchSimilarRecipes() async {
    try {
      final jsonResponse = await fetchSimilarRecipes(_recipe!.id);

      // get list of similar_recipes
      List<SimilarRecipe> similarRecipes = [];
      for (var recipe in jsonResponse) {
        similarRecipes.add(SimilarRecipe.fromJson(recipe));
      }

      _recipe = _recipe!.copyWith(similarRecipes: similarRecipes);

      // dont wait
      updateDatabaseWithNewRecipe(_recipe!);

      return AsyncValue.data(similarRecipes);
    } catch (e, stackTrace) {
      return AsyncValue.error(
        'Couldnt Obtain Similar Recipes For Recipe:${_recipe!.title} \n $e',
        stackTrace,
      );
    }
  }

  // Used for Instruction Paragraph view
  Future<void> getMissingDataForRecipe() async {
    try {
      await ref
          .watch(recipeSearchResultsDatabaseProvider)
          .replaceRecipeDataWithFullData(recipeListIndex + 1);

      state = AsyncValue.data(await ref
          .watch(recipeSearchResultsDatabaseProvider)
          .getSingleRecipe(recipeListIndex));
    } catch (e) {
      throw '$e';
    }
  }

  Future<void> updateDatabaseWithNewRecipe(Recipe newRecipe) async {
    try {
      if (database != null) {
        ref.read(database).updateOrAddRecipe(newRecipe);
        // will cause unnecessary rebuilds
        //state = AsyncValue.data(newRecipe);
      } else {}
    } catch (e) {
      throw 'Failed to update datbase from recipe display manager: $e';
    }
  }
}
