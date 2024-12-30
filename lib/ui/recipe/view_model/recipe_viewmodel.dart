import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/similar_recipe_model.dart';
import '../../../domain/models/recipe_model.dart';
import '../../../data/repositories/recipe_data_repository.dart';

enum InstructionView {
  list,
  paragraph,
}

class RecipeViewmodel extends StateNotifier<RecipeModel> {
  final RecipeDataRepository recipeDataRepository;
  final int recipeListIndex;

  RecipeViewmodel(this.recipeDataRepository, this.recipeListIndex)
      : super(recipeDataRepository.getRecipe(recipeListIndex));

  Future<List<SimilarRecipeModel>> searchSimilarRecipes(int id) async {
    try {
      return await recipeDataRepository.searchForSimilarRecipes(id);
    } catch (e) {
      throw e;
    }
  }

  Future<void> getParagraphDataForRecipe(
    int recipeId,
  ) async {
    try {
      await recipeDataRepository.replaceRecipeDataWithFullData(
        recipeId,
        recipeListIndex,
      );
      state = recipeDataRepository.getRecipe(recipeListIndex);
    } catch (e) {
      throw '$e';
    }
  }
}

final recipeViewModelProvider =
    StateNotifierProvider.family<RecipeViewmodel, RecipeModel, int>(
  (ref, recipeListIndex) {
    final recipeDataRepository = ref.read(recipeDataRepositoryProvider);
    return RecipeViewmodel(recipeDataRepository, recipeListIndex);
  },
);
