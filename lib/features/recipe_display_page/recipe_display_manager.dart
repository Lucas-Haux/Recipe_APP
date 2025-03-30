import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/services/recipe_favorites/recipe_favorites_database.dart';
import 'package:recipe_box/shared/services/recipe_search_results/recipe_search_results_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_display_manager.g.dart';

@riverpod
class RecipeDisplayManager extends _$RecipeDisplayManager {
  @override
  FutureOr<Recipe> build(int recipeListIndex) async {
    try {
      final recipe = await ref
          .watch(recipeSearchResultsDatabaseProvider)
          .getSingleRecipe(recipeListIndex);
      //isFavoirte = await ref
      //    .watch(favoritesDatabaseProvider)
      //    .checkIfRecipeIsFavorite(recipe.recipeId);

      return recipe;
    } catch (e) {
      throw "Failed to build recipe display manager: $e";
    }
  }

  late bool isFavoirte;

  // Used for similar recipes
  Future<void> searchSimilarRecipes() async {
    try {
      await ref
          .watch(recipeSearchResultsDatabaseProvider)
          .addSimilarRecipesToRecipe(recipeListIndex + 1);

      state = AsyncValue.data(await ref
          .watch(recipeSearchResultsDatabaseProvider)
          .getSingleRecipe(recipeListIndex));
    } catch (e) {
      throw '$e';
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
}
