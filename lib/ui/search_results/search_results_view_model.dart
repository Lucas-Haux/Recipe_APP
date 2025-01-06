import '../../../data/repositories/recipe_data_repository.dart';
import '../../../data/model/data_state_status_model.dart';
import '../../../domain/models/recipe_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchResultsViewModel
    extends StateNotifier<DataStateStatusModel<List<RecipeModel>>> {
  final RecipeDataRepository repository;

  SearchResultsViewModel(this.repository)
      //TODO couldnt i make the screen not have the init state if this super calls searchREcipes
      : super(DataStateStatusModel.loading());

  // search Recipes from list
  Future<void> searchForRecipes() async {
    state = DataStateStatusModel.loading(); // Set loading state
    try {
      final recipes = await repository.searchForRecipes();
      state = DataStateStatusModel.completed(recipes); // Set completed state
    } catch (e) {
      state = DataStateStatusModel.error(e.toString()); // Set error state
    }
  }

  int? getTotalRecipeResults() {
    return repository.totalRecipeResults;
  }
}

final searchResultsViewModelProvider = StateNotifierProvider<
    SearchResultsViewModel, DataStateStatusModel<List<RecipeModel>>>(
  (ref) {
    final repository = ref.watch(recipeDataRepositoryProvider.notifier);
    return SearchResultsViewModel(repository);
  },
);
