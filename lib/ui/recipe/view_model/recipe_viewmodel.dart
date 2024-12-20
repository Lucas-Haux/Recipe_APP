import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/similar_recipe_model.dart';
import '../../../data/repositories/recipe_data_repository.dart';

class RecipeViewmodel extends StateNotifier<List<SimilarRecipeModel>> {
  final RecipeDataRepository recipeDataRepository;

  RecipeViewmodel(this.recipeDataRepository)
      : super(recipeDataRepository.similarRecipes);

  Future<void> searchSimilarRecipes(int id) async {
    try {
      await recipeDataRepository.searchForSimilarRecipes(id);
      state = List.from(recipeDataRepository.similarRecipes);
    } catch (e) {
      throw e;
    }
  }
}

final recipeViewmodelProvider =
    StateNotifierProvider<RecipeViewmodel, List<SimilarRecipeModel>>((ref) {
  final recipeDataRepository = RecipeDataRepository();
  return RecipeViewmodel(recipeDataRepository);
});
