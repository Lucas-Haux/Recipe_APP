import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/data/repositories/search_pramaters_repository.dart';
import 'package:recipe_box/domain/enums.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';
import '../../../data/repositories/recipe_data_repository.dart';

class SearchViewModel {
  final WidgetRef ref;

  SearchViewModel(this.ref);

  SearchParameters get searchParameters =>
      ref.watch(searchPramatersRepositoryProvider);

  void setQuery(String query) {
    print('view_model');
    ref.read(searchPramatersRepositoryProvider.notifier).updateQuery(query);
  }

  void setSelectedCuisines(CuisineType newCuisine) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateSelectedCuisines(newCuisine);
  }

  void setDeselectedCuisines(CuisineType newCuisine) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateDeselectedCuisines(newCuisine);
  }

  void setRequiredDiets(DietType newDiet) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateRequiredDiets(newDiet);
  }

  void setDietAndOr(AndOrType newAndOr) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateDietAndOr(newAndOr);
  }

  void setIntolerance(IntoleranceType newIntolerance) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateIntolerances(newIntolerance);
  }

  Future<void> searchForRecipes() async {
    ref.read(recipeDataRepositoryProvider).searchForRecipes();
  }
}
