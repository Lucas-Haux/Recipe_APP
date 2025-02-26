import 'package:recipe_box/data/model/recipe_search_data_model.dart';
import 'package:recipe_box/data/repositories/recipe_data_repository/recipe_data_repository.dart';
import 'package:recipe_box/data/repositories/search_pramaters_repository/search_pramaters_repository.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';

import '../../../domain/models/recipe_model.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_results_view_model.g.dart';

@riverpod
class SearchResultsViewModel extends _$SearchResultsViewModel {
  @override
  AsyncValue<RecipeSearchDataModel> build() {
    return AsyncLoading();
  }

  Future<List<RecipeModel>> getArticleListPage(
    num pageNumber,
    num size,
  ) async {
    try {
      print("ran search_results viewmodel");
      SearchParameters searchParamaters = await ref
          .watch(searchParametersRepositoryProvider)
          .getSearchParameters();

      print("got searchParamaters");

      RecipeSearchDataModel response =
          await ref.read(recipeDataRepositoryProvider).searchForRecipes(
                pageNumber,
                size,
                searchParamaters,
              );

      if (state.hasValue) {
        response.usedTokens = state.value!.usedTokens + response.usedTokens;
      }

      state = AsyncData(response);

      return response.recipeData;
    } catch (e) {
      throw 'failed get article list page search thing $e';
    }
  }
}
