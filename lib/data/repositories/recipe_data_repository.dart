import '../../data/services/recipe_search_service.dart';
import '../../domain/models/recipe_model.dart';
import '../../data/model/data_state_status_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

String query = '';

class RecipeDataRepository {
  List<RecipeModel> _recipesList = [];

  List<RecipeModel> get recipes => _recipesList;

  Future<List<RecipeModel>> searchForRecipes() async {
    try {
      // Fetch API response wiht service
      dynamic jsonResponse = await RecipeSearchService().fetchRecipes(query);

      // Parse JSON into RecipeModel list
      _recipesList = jsonResponse['results']
          .map<RecipeModel>((jsonMap) => RecipeModel.fromJson(jsonMap))
          .toList();

      return _recipesList;
      // make the recipelist the state of the notifier
    } catch (e) {
      throw Exception('Error searching for recipes: $e');
    }
  }
}

final recipeRepositoryProvider =
    Provider<RecipeDataRepository>((ref) => RecipeDataRepository());
