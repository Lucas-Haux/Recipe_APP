import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/data/repositories/search_pramaters_repository/abstract_search_pramaters_repository.dart';
import 'package:recipe_box/domain/enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/models/search_parameters_model.dart';

part 'search_pramaters_repository.g.dart';

@Riverpod(keepAlive: false)
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
  SearchParameters getSearchParameters() {
    try {
      if (searchParameters == null) {
        throw "searchParamaters is null";
      }

      return searchParameters!;
    } catch (e) {
      throw "****** Failed to get searchParamaters in searchParamaters repo $e";
    }
  }

  @override
  void updateState({
    String? query,
    AndOrType? dietAndOr,
    double? maxTime,
    RangeValues? calories,
    RangeValues? servings,
    RangeValues? protein,
    RangeValues? fat,
    Map<MealType, AndOrType>? meals,
    Map<CuisineType, RequireExclude>? cuisines,
    Map<DietType, AndOrType>? diets,
    Map<EquipmentType, AndOrType>? equipment,
    Map<IntoleranceType, RequireExclude>? intolerances,
    Map<String, RequireExclude>? ingredients,
  }) {
    try {
      dynamic newMap;
      // TODO remove the amount of if statements

      if (cuisines != null) {
        // copy
        newMap = searchParameters!.cuisines;
        // update the given CuisineType with the new value
        newMap.update(cuisines.keys.first,
            (existingValue) => cuisines[cuisines.keys.first]!);
      } else if (diets != null) {
        // copy
        newMap = searchParameters!.diets;
        newMap.update(
            diets.keys.first, (existingValue) => diets[diets.keys.first]!);
      } else if (intolerances != null) {
        newMap = searchParameters!.intolerances;
        newMap.update(intolerances.keys.first,
            (existingValue) => intolerances[intolerances.keys.first]!);
      } else if (meals != null) {
        newMap = searchParameters!.meals;
        newMap.update(
            meals.keys.first, (existingValue) => meals[meals.keys.first]!);
      } else if (equipment != null) {
        newMap = searchParameters!.equipment;
        newMap.update(equipment.keys.first,
            (existingValue) => equipment[equipment.keys.first]!);
      }

      searchParameters = searchParameters!.copyWith(
        query: query ?? searchParameters!.query,
        maxTime: maxTime ?? searchParameters!.maxTime,
        calories: calories ?? searchParameters!.calories,
        servings: servings ?? searchParameters!.servings,
        protein: protein ?? searchParameters!.protein,
        fat: fat ?? searchParameters!.fat,
        meals: meals != null
            ? (newMap ?? searchParameters!.meals)
            : searchParameters!.meals,
        cuisines: cuisines != null
            ? (newMap ?? searchParameters!.cuisines)
            : searchParameters!.cuisines,
        diets: diets != null
            ? (newMap ?? searchParameters!.diets)
            : searchParameters!.diets,
        equipment: equipment != null
            ? (newMap ?? searchParameters!.equipment)
            : searchParameters!.equipment,
        intolerances: intolerances != null
            ? (newMap ?? searchParameters!.intolerances)
            : searchParameters!.intolerances,
        ingredients: ingredients,
      );
      print('!!!!!!!!!!!!');
      print(searchParameters!.ingredients);
    } catch (e) {
      throw e;
    }
  }

  @override
  resetToDefaults() {}
}
