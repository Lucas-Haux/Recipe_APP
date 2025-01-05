import '../../data/services/recipe_search_service.dart';
import '../../data/services/similar_recipe_service.dart';
import '../../data/services/recipe_full_info_service.dart';
import '../../domain/models/recipe_model.dart';
import '../../domain/models/similar_recipe_model.dart';
import '../../data/model/data_state_status_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class RecipeDataRepository extends StateNotifier<List<RecipeModel>> {
  final Ref ref;
  RecipeDataRepository(this.ref) : super([]);

  Provider searchService = recipeSearchServiceProvider;

  List<RecipeModel> _cachedRecipesList = [];
  int? _cachedTotalRecipeResults;

  List<RecipeModel> get recipes => _cachedRecipesList;
  RecipeModel recipe(int index) => _cachedRecipesList[index];
  int? get totalRecipeResults => _cachedTotalRecipeResults;

  // use spoonacular api to get list of recipes
  Future<List<RecipeModel>> searchForRecipes() async {
    try {
      // Fetch API
      dynamic jsonResponse = await ref.read(searchService).fetchRecipes();

      // Parse JSON into RecipeModel list
      _cachedRecipesList = jsonResponse['results']
          .map<RecipeModel>((jsonMap) => RecipeModel.fromJson(jsonMap))
          .toList();

      state = _cachedRecipesList;

      _cachedTotalRecipeResults = jsonResponse['totalResults'];
      print(' new _cachedTotalRecipeResults $_cachedTotalRecipeResults');

      return _cachedRecipesList;
    } catch (e) {
      throw Exception('Error searching for recipes: $e');
    }
  }

  // Replace recipe with a recipe with full data
  Future<void> replaceRecipeDataWithFullData(
    int recipeId,
    int recipeListIndex,
  ) async {
    try {
      dynamic jsonResponse =
          await RecipeFullInfoService().fetchFullRecipe(recipeId);

      _cachedRecipesList = List.from(_cachedRecipesList)
        ..[recipeListIndex] = RecipeModel.fromJson(jsonResponse);
      state = _cachedRecipesList;
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

final recipeDataRepositoryProvider =
    StateNotifierProvider<RecipeDataRepository, List<RecipeModel>>(
  (ref) => RecipeDataRepository(ref),
);

// Returns the whole list
final recipeListProvider = Provider<List<RecipeModel>>((ref) {
  final recipes = ref.watch(recipeDataRepositoryProvider);
  return recipes;
});
