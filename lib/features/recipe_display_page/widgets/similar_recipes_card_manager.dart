import 'package:recipe_box/features/recipe_display_page/recipe_display_manager.dart';
import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/services/remote/similar_recipes.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'similar_recipes_card_manager.g.dart';

@riverpod
class SimilarRecipesCardManager extends _$SimilarRecipesCardManager {
  @override
  AsyncValue<List<SimilarRecipe>?> build(dynamic database, Recipe recipe) {
    try {
      return AsyncValue.data(recipe.similarRecipes);
    } catch (e) {
      throw "Failed to build recipe display manager: $e";
    }
  }

  Future<void> searchForSimilarRecipes() async {
    try {
      state = AsyncValue.loading();

      final jsonResponse = await fetchSimilarRecipes(recipe.id);

      // get list of similar_recipes
      List<SimilarRecipe> similarRecipes = [];
      for (var recipe in jsonResponse) {
        similarRecipes.add(SimilarRecipe.fromJson(recipe));
      }

      state = AsyncValue.data(similarRecipes);

      final newRecipe = recipe.copyWith(similarRecipes: similarRecipes);

      await ref
          .read(recipeDisplayManagerProvider(database, recipe.id).notifier)
          .updateDatabaseWithNewRecipe(newRecipe);
    } catch (e) {
      throw 'Failed to searchForSimilarRecipes in similar_recipes_card_manage: $e';
    }
  }
}
