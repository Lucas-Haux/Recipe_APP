import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/data/repositories/favorites_repository/favorites_repository.dart';
import '../../../domain/models/recipe_model.dart';
import '../../data/repositories/recipe_data_repository/recipe_data_repository.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_viewmodel.g.dart';

@riverpod
class RecipeViewmodel extends _$RecipeViewmodel {
  @override
  FutureOr<RecipeModel> build(int recipeListIndex) async {
    try {
      final recipe = await ref
          .watch(recipeDataRepositoryProvider)
          .getSingleRecipe(recipeListIndex);
      isFavoirte = await ref
          .watch(favoritesRepositoryProvider)
          .checkIfRecipeIsFavorite(recipe.recipeId);

      return recipe;
    } catch (e) {
      throw "Failed to build recipe_viewmodel $e";
    }
  }

  late bool isFavoirte;

  // Used for similar recipes
  Future<void> searchSimilarRecipes() async {
    try {
      await ref
          .watch(recipeDataRepositoryProvider)
          .addSimilarRecipesToRecipe(recipeListIndex + 1);

      state = AsyncValue.data(await ref
          .watch(recipeDataRepositoryProvider)
          .getSingleRecipe(recipeListIndex));
    } catch (e) {
      throw '$e';
    }
  }

  // Used for Instruction Paragraph view
  Future<void> getMissingDataForRecipe() async {
    try {
      await ref
          .watch(recipeDataRepositoryProvider)
          .replaceRecipeDataWithFullData(recipeListIndex + 1);

      state = AsyncValue.data(await ref
          .watch(recipeDataRepositoryProvider)
          .getSingleRecipe(recipeListIndex));
    } catch (e) {
      throw '$e';
    }
  }
}
