import 'package:recipe_box/data/repositories/recipe_data_repository/recipe_data_repository.dart';

import '../../../domain/models/recipe_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_results_view_model.g.dart';

@riverpod
class SearchResultsViewModel extends _$SearchResultsViewModel {
  @override
  FutureOr<List<RecipeModel>> build() async {
    await ref.read(recipeDataRepositoryProvider).searchForRecipes();
    final recipes = ref.watch(recipeDataRepositoryProvider).getRecipes();
    return recipes;
  }

  // search Recipes from list

  int? getTotalRecipeResults() {
    return 420;
    // return ref.read(recipeDataRepositoryProvider).totalRecipeResults;
  }
}
