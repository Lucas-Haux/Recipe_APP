import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../data/services/recipe_search_service.dart';
import '../../../data/services/similar_recipe_service.dart';
import '../../../data/services/recipe_full_info_service.dart';
import '../../../domain/models/recipe_model.dart';
import 'dart:async';

part 'recipe_data_repository.g.dart';

class RecipeException implements Exception {
  final String message;
  final dynamic error;

  RecipeException(this.message, [this.error]);

  @override
  String toString() =>
      'RecipeException: $message${error != null ? ' ($error)' : ''}';
}

abstract class RecipeDataRepository {
  Future<List<RecipeModel>> getRecipes();

  Future<RecipeModel> getSingleRecipe(int recipeListIndex);

  Future<void> searchForRecipes();

  Future<void> replaceRecipeData(int recipeListIndex);

  Future<void> addSimilarRecipesToRecipe(int recipeListIndex);
}

@Riverpod(keepAlive: true)
RecipeDataRepository recipeDataRepository(Ref ref) =>
    LocalRecipeDataRepository();

class LocalRecipeDataRepository implements RecipeDataRepository {
  static const String _boxName = 'recipesListBox';

  Future<Box<RecipeModel>> _openBox() async {
    try {
      if (Hive.isBoxOpen(_boxName)) {
        return Hive.box<RecipeModel>(_boxName);
      }
      return await Hive.openBox<RecipeModel>(_boxName);
    } catch (e) {
      throw RecipeException('Failed to open recipesList Box', e);
    }
  }

  @override
  Future<List<RecipeModel>> getRecipes() async {
    try {
      final box = await _openBox();
      print(box.values.toList().length);
      return box.values.toList();
    } catch (e) {
      throw RecipeException('Failed to get Recipes', e);
    }
  }

  @override
  Future<RecipeModel> getSingleRecipe(int recipeListIndex) async {
    try {
      final box = await _openBox();
      print('yes1');
      return box.values.toList()[recipeListIndex];
    } catch (e) {
      throw RecipeException('Failed to get single recipe', e);
    }
  }

  @override
  Future<void> searchForRecipes() async {
    try {
      final box = await _openBox();

      box.deleteAll(box.keys);

      dynamic jsonResponse = await RecipeSearchService().fetchRecipes();

      List<RecipeModel> tempList = jsonResponse['results']
          .map<RecipeModel>((jsonMap) => RecipeModel.fromJson(jsonMap))
          .toList();

      for (var recipe in tempList) {
        box.add(recipe);
      }
    } catch (e) {
      throw RecipeException('Error searching for recipe:', e);
    }
  }

  @override
  Future<void> replaceRecipeData(int recipeListIndex) async {
    try {
      final box = await _openBox();

      // Check if recipeList is valid
      if (recipeListIndex < 0 || recipeListIndex >= box.length) {
        throw RecipeException('Invalid recipe index: $recipeListIndex');
      }

      final oldRecipe = box.getAt(recipeListIndex);
      if (oldRecipe == null) {
        throw RecipeException('No recipe found at index: $recipeListIndex');
      }

      // Fetch updated recipe data
      final jsonResponse =
          await RecipeFullInfoService().fetchFullRecipe(oldRecipe.id);
      final newRecipe = RecipeModel.fromJson(jsonResponse);
      // Replace the recipe without deleting to avoid shifting indexes
      await box.putAt(recipeListIndex, newRecipe);
    } catch (e) {
      throw RecipeException('Error replacing recipe data:', e);
    }
  }

  @override
  Future<void> addSimilarRecipesToRecipe(int recipeListIndex) async {
    try {
      final box = await _openBox();

      final oldRecipe = box.values.toList()[recipeListIndex];

      final jsonResponse =
          await SimilarRecipeService().fetchSimilarRecipes(oldRecipe.id);

      final List<SimilarRecipeModel> newList = [];

      for (var response in jsonResponse) {
        var similarRecipe = SimilarRecipeModel.fromJson(response);
        newList.add(similarRecipe);
      }

      print('1');
      print(box.values.toList()[recipeListIndex].similarRecipes?.isEmpty);

      box.putAt(recipeListIndex, oldRecipe.copyWith(similarRecipes: newList));
      print('2');

      print(box.values.toList()[recipeListIndex].similarRecipes?.isEmpty);
    } catch (e) {
      throw RecipeException('Error adding  Similar recipes:', e);
    }
  }
}
