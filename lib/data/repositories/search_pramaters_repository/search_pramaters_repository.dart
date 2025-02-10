import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/data/repositories/search_pramaters_repository/abstract_search_pramaters_repository.dart';
import 'package:recipe_box/domain/enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/models/search_parameters_model.dart';

part 'search_pramaters_repository.g.dart';

@Riverpod(keepAlive: true)
AbstractSearchParamatersRepository searchParametersRepository(Ref ref) =>
    LocalSearchParametersRepository();

class LocalSearchParametersRepository
    implements AbstractSearchParamatersRepository {
  SearchParameters? searchParameters;
  @override
  LocalSearchParametersRepository() {
    searchParameters = SearchParameters();
  }

  @override
  SearchParameters getSearchParameters() => searchParameters!;

  @override
  void updateState({
    String? query,
    AndOrType? dietAndOr,
    double? maxTime,
    double? maxCalories,
    double? minCalories,
    double? maxServings,
    double? minServings,
    double? maxProtein,
    double? minProtein,
    double? maxFat,
    double? minFat,
    Map<DietType, AndOrType>? diets,
    Map<CuisineType, RequireExclude>? cuisines,
    Map<IntoleranceType, RequireExclude>? intolerances,
  }) {
    try {
      dynamic newMap;

      if (cuisines != null) {
        // copy
        newMap = searchParameters!.cuisines;
        // update the given CuisineType with the new value
        newMap.update(cuisines.keys.first,
            (existingValue) => cuisines[cuisines.keys.first]!);
      } else if (diets != null) {
        print('!!!!!!!!!!!!!! Diets is not null in repo');
        // copy
        newMap = searchParameters!.diets;
        newMap.update(
            diets.keys.first, (existingValue) => diets[diets.keys.first]!);
      } else if (intolerances != null) {
        newMap = searchParameters!.intolerances;
        newMap.update(intolerances.keys.first,
            (existingValue) => intolerances[intolerances.keys.first]!);
      }

      searchParameters = searchParameters!.copyWith(
        query: query ?? searchParameters!.query,
        maxTime: maxTime ?? searchParameters!.maxTime,
        maxCalories: maxCalories ?? searchParameters!.maxCalories,
        minCalories: minCalories ?? searchParameters!.minCalories,
        maxServings: maxServings ?? searchParameters!.maxServings,
        minServings: minServings ?? searchParameters!.minServings,
        maxProtein: maxProtein ?? searchParameters!.maxProtein,
        minProtein: minProtein ?? searchParameters!.minProtein,
        maxFat: maxFat ?? searchParameters!.maxFat,
        minFat: minFat ?? searchParameters!.minFat,
        cuisines: cuisines != null
            ? (newMap ?? searchParameters!.cuisines)
            : searchParameters!.cuisines,
        diets: diets != null
            ? (newMap ?? searchParameters!.diets)
            : searchParameters!.diets,
        intolerances: intolerances != null
            ? (newMap ?? searchParameters!.intolerances)
            : searchParameters!.intolerances,
      );
    } catch (e) {
      throw e;
    }
  }

  @override
  resetToDefaults() {}
}
