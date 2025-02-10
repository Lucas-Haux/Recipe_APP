import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';
import 'dart:async';

class RecipeException implements Exception {
  final String message;
  final dynamic error;

  RecipeException(this.message, [this.error]);

  @override
  String toString() =>
      'RecipeException: $message${error != null ? ' ($error)' : ''}';
}

abstract class AbstractRecipeDataRepository {
  Future<List<RecipeModel>> searchForRecipes(
    int pageNumber,
    int size,
    SearchParameters searchParamaters,
  );

  Future<List<RecipeModel>> getRecipes();

  Future<RecipeModel> getSingleRecipe(int recipeListIndex);

  Future<void> replaceRecipeData(int recipeListIndex);

  Future<void> addSimilarRecipesToRecipe(int recipeListIndex);
}
