import 'package:recipe_box/data/repositories/recipe_data_repository/recipe_data_repository.dart';
import 'package:recipe_box/data/repositories/search_pramaters_repository/search_pramaters_repository.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';

import '../../../domain/models/recipe_model.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_results_view_model.g.dart';

@riverpod
class SearchResultsViewModel extends _$SearchResultsViewModel {
  @override
  FutureOr<void> build() {}

  Future<List<RecipeModel>> getArticleListPage(
    int pageNumber,
    int size,
  ) {
    try {
      SearchParameters searchParamaters =
          ref.watch(searchParametersRepositoryProvider).getSearchParameters();

      return ref.read(recipeDataRepositoryProvider).searchForRecipes(
            pageNumber,
            size,
            searchParamaters,
          );
    } catch (e) {
      throw 'failed get article list page search thing $e';
    }
  }

  int? getTotalRecipeResults() {
    return 420;
    // return ref.read(recipeDataRepositoryProvider).totalRecipeResults;
  }
}
