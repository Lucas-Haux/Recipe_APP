import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/recipe_model.dart';
import '../../data/repositories/recipe_data_repository/recipe_data_repository.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_viewmodel.g.dart';

@riverpod
class RecipeViewmodel extends _$RecipeViewmodel {
  @override
  FutureOr<RecipeModel> build(int recipeListIndex) async {
    try {
      print('ran build()');
      final recipe = await ref
          .watch(recipeDataRepositoryProvider)
          .getSingleRecipe(recipeListIndex);
      return recipe;
    } catch (e) {
      throw e;
    }
  }

  // Used for similar recipes
  Future<void> searchSimilarRecipes() async {
    try {
      //state = const AsyncLoading();

      //state = await AsyncValue.guard(() async {
      //await repository.addSimilarRecipesToRecipe(recipeListIndex);
      //return repository.getSingleRecipe(recipeListIndex);
      throw UnimplementedError();
      //});

      // build(recipeListIndex);
    } catch (e) {
      throw '$e';
    }
  }

  // Used for Instruction Paragraph view
  Future<void> getParagraphDataForRecipe() async {
    try {
      //state = const AsyncLoading();

      //state = await AsyncValue.guard(() async {
      //await repository.replaceRecipeData(recipeListIndex);
      //return repository.getSingleRecipe(recipeListIndex);
      //});

      throw UnimplementedError();
      //build(recipeListIndex)
    } catch (e) {
      throw '$e';
    }
  }
}
