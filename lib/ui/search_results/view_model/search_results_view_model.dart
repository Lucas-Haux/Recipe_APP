import '../../../data/repositories/recipe_data_repository.dart';
import '../../../data/model/data_state_status_model.dart';
import '../../../domain/models/recipe_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeViewModel
    extends StateNotifier<DataStateStatusModel<List<RecipeModel>>> {
  final RecipeDataRepository repository;

  RecipeViewModel(this.repository) : super(DataStateStatusModel.loading());

  Future<void> searchForRecipes() async {
    state = DataStateStatusModel.loading(); // Set loading state
    try {
      final recipes = await repository.searchForRecipes();
      state = DataStateStatusModel.completed(recipes); // Set completed state
    } catch (e) {
      state = DataStateStatusModel.error(e.toString()); // Set error state
    }
  }
}

final recipeViewModelProvider = StateNotifierProvider<RecipeViewModel,
    DataStateStatusModel<List<RecipeModel>>>(
  (ref) {
    final repository = ref.watch(recipeRepositoryProvider);
    return RecipeViewModel(repository);
  },
);
