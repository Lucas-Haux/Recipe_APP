import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/data/repositories/recipe_data_repository/recipe_data_repository.dart';
import 'package:recipe_box/data/repositories/search_pramaters_repository.dart';
import 'package:recipe_box/domain/enums.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';

class SearchViewModel {
  final WidgetRef ref;

  SearchViewModel(this.ref);

  SearchParameters get searchParameters =>
      ref.watch(searchPramatersRepositoryProvider);

  void setIntolerance(IntoleranceType newIntolerance) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateIntolerances(newIntolerance);
  }

  void setMaxReadyTime(double newTime) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateState(newMaxTime: newTime);
  }

  void setMaxCalories(double newCalories) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateState(newMaxCalories: newCalories);
  }

  void setMinCalories(double newCalories) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateState(newMinCalories: newCalories);
  }

  void setMaxServings(double newServings) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateState(newMaxServings: newServings);
  }

  void setMinServings(double newServings) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateState(newMinServings: newServings);
  }

  void setMaxProtein(double newProtein) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateState(newMaxProtein: newProtein);
  }

  void setMinProtein(double newProtein) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateState(newMinProtein: newProtein);
  }

  void setMaxFat(double newFat) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateState(newMaxFat: newFat);
  }

  void setMinFat(double newFat) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateState(newMinFat: newFat);
  }

  void setDietAndOr(AndOrType newAndOr) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateState(newDietAndOr: newAndOr);
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

  void setQuery(String newQuery) {
    ref
        .read(searchPramatersRepositoryProvider.notifier)
        .updateState(newQuery: newQuery);
  }

  Future<void> searchForRecipes() async {
    ref.read(recipeDataRepositoryProvider).searchForRecipes();
  }
}
