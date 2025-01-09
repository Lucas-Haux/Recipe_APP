import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/domain/enums.dart';
import '../../domain/models/search_parameters_model.dart';

class SearchPramatersRepository extends StateNotifier<SearchParameters> {
  SearchPramatersRepository() : super(SearchParameters());

  // selected Cuisines
  void updateSelectedCuisines(CuisineType newSelection) {
    final newSelectedCuisines = Set<CuisineType>.from(state.selectedCuisines);
    final newDeselectedCuisines =
        Set<CuisineType>.from(state.deselectedCuisines);

    // remove newSelection if in selection/deselection
    if (newSelectedCuisines.contains(newSelection)) {
      newSelectedCuisines.remove(newSelection);
    } else if (newDeselectedCuisines.contains(newSelection)) {
      newDeselectedCuisines.remove(newSelection);
    } else {
      // add to selectedCuisines
      newSelectedCuisines.add(newSelection);
    }

    state = state.copyWith(selectedCuisines: newSelectedCuisines);
    state = state.copyWith(deselectedCuisines: newDeselectedCuisines);
  }

  // deselected Cuisines
  void updateDeselectedCuisines(CuisineType newSelection) {
    final newSelectedCuisines = Set<CuisineType>.from(state.selectedCuisines);
    final newDeselectedCuisines =
        Set<CuisineType>.from(state.deselectedCuisines);

    // remove newSelection if in selection/deselection
    if (newDeselectedCuisines.contains(newSelection)) {
      newDeselectedCuisines.remove(newSelection);
    } else if (newSelectedCuisines.contains(newSelection)) {
      newSelectedCuisines.remove(newSelection);
    } else {
      // add to deselectedCuisines
      newDeselectedCuisines.add(newSelection);
    }

    state = state.copyWith(selectedCuisines: newSelectedCuisines);
    state = state.copyWith(deselectedCuisines: newDeselectedCuisines);
  }

  // required Diets
  void updateRequiredDiets(DietType newDiet) {
    final newRequiredDiets = Set<DietType>.from(state.requiredDiets);

    if (newRequiredDiets.contains(newDiet)) {
      newRequiredDiets.remove(newDiet);
    } else {
      newRequiredDiets.add(newDiet);
    }

    state = state.copyWith(requiredDiets: newRequiredDiets);
  }

  // intolerances
  void updateIntolerances(IntoleranceType newIntolerance) {
    final newIntolerances = Set<IntoleranceType>.from(state.intolerances);

    if (newIntolerances.contains(newIntolerance)) {
      newIntolerances.remove(newIntolerance);
    } else {
      newIntolerances.add(newIntolerance);
    }

    state = state.copyWith(intolerances: newIntolerances);
  }

  void updateState({
    String? newQuery,
    AndOrType? newDietAndOr,
    double? newMaxTime,
    double? newMaxCalories,
    double? newMinCalories,
    double? newMaxServings,
    double? newMinServings,
    double? newMaxProtein,
    double? newMinProtein,
    double? newMaxFat,
    double? newMinFat,
  }) {
    state = state.copyWith(
      query: newQuery ?? state.query,
      dietAndOr: newDietAndOr ?? state.dietAndOr,
      maxTime: newMaxTime ?? state.maxTime,
      maxCalories: newMaxCalories ?? state.maxCalories,
      minCalories: newMinCalories ?? state.minCalories,
      maxServings: newMaxServings ?? state.maxServings,
      minServings: newMinServings ?? state.minServings,
      maxProtein: newMaxProtein ?? state.maxProtein,
      minProtein: newMinProtein ?? state.minProtein,
      maxFat: newMaxFat ?? state.maxFat,
      minFat: newMinFat ?? state.minFat,
    );
  }
}

final searchPramatersRepositoryProvider =
    StateNotifierProvider<SearchPramatersRepository, SearchParameters>(
  (ref) => SearchPramatersRepository(),
);
