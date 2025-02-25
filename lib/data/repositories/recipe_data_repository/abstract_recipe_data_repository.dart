import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';
import 'dart:async';

class RecipeException implements Exception {
  final String message;
  final dynamic error;
  final dynamic stackTrace;

  RecipeException(this.message, [this.error, this.stackTrace]);

  @override
  String toString() {
    return 'RecipeException: $message'
        '${error != null ? ' (Error: $error)' : ''}'
        '${stackTrace != null ? '\nStackTrace: $stackTrace' : ''}';
  }
}

abstract class AbstractRecipeDataRepository {
  Future<List<RecipeModel>> searchForRecipes(
    num pageNumber,
    num size,
    SearchParameters searchParamaters,
  );

  Future<List<RecipeModel>> getRecipes();

  Future<RecipeModel> getSingleRecipe(int recipeListIndex);

  Future<void> replaceRecipeDataWithFullData(int recipeListIndex);

  Future<void> addSimilarRecipesToRecipe(int recipeListIndex);

  Future<void> clearDB();
}
