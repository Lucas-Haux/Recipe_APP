import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/services/recipe_favorites/recipe_favorites_database.dart';
import 'package:recipe_box/shared/services/recipe_search_results/apis/recipe_data.dart';
import 'package:recipe_box/shared/services/recipe_search_results/recipe_search_results_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_display_search_manager.g.dart';

final recipeListIndex = 1;

@riverpod
class RecipeDisplayManager extends _$RecipeDisplayManager {
  @override
  FutureOr<Recipe> build(String route, int recipeId) async {
    try {
      switch (route) {
        case '/searchPage/searchResults/recipe':
          database = recipeSearchResultsDatabaseProvider;
        case '/recipe':
          database = favoritesDatabaseProvider;
        case '/favorites/recipe':
          database = favoritesDatabaseProvider;
        default:
          database = null;
      }

      late Recipe newRecipe;
      if (database != null) {
        newRecipe = await ref.watch(database).getSingleRecipe(recipeId)!;
      } else {
        newRecipe = await RecipeData().fetchFullRecipe(recipeId);
      }

      isFavoirte = await ref
          .watch(favoritesDatabaseProvider)
          .checkIfRecipeIsFavorite(newRecipe.recipeId);

      return newRecipe;
    } catch (e) {
      throw "Failed to build recipe display manager: $e";
    }
  }

  late bool isFavoirte;
  late dynamic database;

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
