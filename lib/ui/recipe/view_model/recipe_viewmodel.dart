import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/similar_recipe_model.dart';
import '../../../data/repositories/recipe_data_repository.dart';

class RecipeViewmodel {
  final RecipeDataRepository recipeDataRepository = RecipeDataRepository();

  Future<List<SimilarRecipeModel>> searchSimilarRecipes(int id) async {
    try {
      return await recipeDataRepository.searchForSimilarRecipes(id);
    } catch (e) {
      throw e;
    }
  }
}
