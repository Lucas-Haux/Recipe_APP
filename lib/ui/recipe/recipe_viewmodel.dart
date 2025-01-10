import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/similar_recipe_model.dart';
import '../../../domain/models/recipe_model.dart';
import '../../../data/repositories/recipe_data_repository.dart';

class RecipeViewmodel {
  final Ref ref;
  final RecipeDataRepository recipeDataRepository;
  final int recipeListIndex;
  RecipeViewmodel(this.recipeDataRepository, this.recipeListIndex, this.ref);

  RecipeModel recipe(int id) => recipeDataRepository.recipe(id);

  // Used for similar recipes
  Future<List<SimilarRecipeModel>> searchSimilarRecipes(int id) async {
    try {
      return await recipeDataRepository.searchForSimilarRecipes(id);
    } catch (e) {
      throw '$e';
    }
  }

  // Used for Instruction Paragraph view
  Future<void> getParagraphDataForRecipe(int recipeId) async {
    try {
      await recipeDataRepository.replaceRecipeDataWithFullData(
        recipeId,
        recipeListIndex,
      );
    } catch (e) {
      throw '$e';
    }
  }
}

final recipeViewModelProvider =
    Provider.family<RecipeViewmodel, int>((ref, recipeListIndex) {
  final recipeDataRepository = ref.watch(recipeDataRepositoryProvider.notifier);
  return RecipeViewmodel(recipeDataRepository, recipeListIndex, ref);
});
