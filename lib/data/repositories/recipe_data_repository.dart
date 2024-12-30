import '../../data/services/recipe_search_service.dart';
import '../../data/services/similar_recipe_service.dart';
import '../../data/services/recipe_full_info_service.dart';
import '../../domain/models/recipe_model.dart';
import '../../domain/models/similar_recipe_model.dart';
import '../../data/model/data_state_status_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

String query = '';
List<RecipeModel> _recipesList = [];

class RecipeDataRepository {
  final Ref ref;

  RecipeDataRepository(this.ref);
  List<RecipeModel> get recipes => _recipesList;

  RecipeModel getRecipe(int recipeListIndex) {
    return _recipesList[recipeListIndex];
  }

  Future<List<RecipeModel>> searchForRecipes() async {
    try {
      // Fetch API response wiht service
      dynamic jsonResponse =
          await ref.read(recipeSearchServiceProvider).fetchRecipes();

      // Parse JSON into RecipeModel list
      _recipesList = jsonResponse['results']
          .map<RecipeModel>((jsonMap) => RecipeModel.fromJson(jsonMap))
          .toList();

      return _recipesList;
    } catch (e) {
      throw Exception('Error searching for recipes: $e');
    }
  }

  Future<void> replaceRecipeDataWithFullData(
    int recipeId,
    int recipeListIndex,
  ) async {
    try {
      print(_recipesList[recipeListIndex].instructionsParagraph);

      dynamic jsonResponse =
          await RecipeFullInfoService().fetchFullRecipe(recipeId);
      // update the RecipeModel with the new RecipeModel with full data
      _recipesList[recipeListIndex] = RecipeModel.fromJson(jsonResponse);
      print(_recipesList[recipeListIndex].instructionsParagraph);
      print(recipes[recipeListIndex].instructionsParagraph);
    } catch (e) {
      throw '$e';
    }
  }

  Future<List<SimilarRecipeModel>> searchForSimilarRecipes(int id) async {
    try {
      dynamic jsonResponse =
          await SimilarRecipeService().fetchSimilarRecipes(id);

      List<SimilarRecipeModel> similarRecipesList = jsonResponse
          .map<SimilarRecipeModel>(
              (jsonMap) => SimilarRecipeModel.fromJson(jsonMap))
          .toList();

      return similarRecipesList;
    } catch (e) {
      throw e;
    }
  }
}

final recipeDataRepositoryProvider = Provider((ref) {
  return RecipeDataRepository(ref);
});
