import 'package:recipe_box/shared/databases/recipe_search_results/model/recipe_search_result.dart';
import 'package:recipe_box/shared/databases/recipe_search_results/recipe_search_results_database.dart';
import 'package:recipe_box/shared/databases/searchs-parameters/search_parameters_database.dart';
import 'package:recipe_box/shared/enums/chip_parameters_modes.dart';
import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/models/search_parameters.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_results_manager.g.dart';

@riverpod
class SearchResultsManager extends _$SearchResultsManager {
  @override
  AsyncValue<RecipeSearchResult> build() {
    return AsyncLoading();
  }

  Future<List<Recipe>> getArticleListPage(
    num pageNumber,
    num size,
  ) async {
    try {
      SearchParameters searchParamaters =
          ref.watch(searchParametersDatabaseProvider).getSearchParameters();

      RecipeSearchResult response =
          await ref.read(recipeSearchResultsDatabaseProvider).searchForRecipes(
                pageNumber,
                size,
                searchParamaters,
              );

      if (state.hasValue && pageNumber != 1) {
        response.usedTokens = state.value!.usedTokens + response.usedTokens;
      }

      state = AsyncData(response);

      return response.recipeData;
    } catch (e) {
      throw 'failed to get search results from manager: $e';
    }
  }

  bool areFiltersModified() {
    SearchParameters searchParameters =
        ref.watch(searchParametersDatabaseProvider).getSearchParameters();

    final values = {
      ...searchParameters.meals.values,
      ...searchParameters.equipment.values,
      ...searchParameters.diets.values,
      ...searchParameters.intolerances.values,
      ...searchParameters.cuisines.values,
    };

    if (values.contains(RequireExclude.require) ||
        values.contains(RequireExclude.exclude) ||
        values.contains(AndOrType.and) ||
        values.contains(AndOrType.or)) {
      return true;
    }

    if (searchParameters.ingredients.isNotEmpty) {
      if (searchParameters.ingredients.keys.length > 1) {
        return true;
      }
      if (searchParameters.ingredients.keys.first.isNotEmpty) {
        return true;
      }
    }

    return false;
  }

  resetUsedTokens() {
    state.value!.usedTokens = 0;
  }
}
