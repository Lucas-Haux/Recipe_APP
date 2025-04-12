import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/shared/enums/chip_parameters_modes.dart';
import 'package:recipe_box/shared/enums/recipe_parameters.dart';
import 'package:recipe_box/shared/models/search_parameters.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_parameters_database.g.dart';

abstract class AbstractSearchParametersDatabase {
  SearchParameters getSearchParameters();

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
    SortType? newSortType,
    bool? matchTitle,
  });

  replaceState(SearchParameters newSearchParameters);

  resetToDefaults(String query);
}

@Riverpod(keepAlive: false)
AbstractSearchParametersDatabase searchParametersDatabase(Ref ref) =>
    LocalSearchParametersDatabase();

class LocalSearchParametersDatabase
    implements AbstractSearchParametersDatabase {
  SearchParameters? searchParameters;
  @override
  LocalSearchParametersDatabase() {
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
      throw "Failed to get searchParamaters in searchParamaters database$e";
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
    SortType? newSortType,
    bool? matchTitle,
  }) {
    try {
      dynamic newMap;
      // TODO remove the amount of if statements

      if (cuisines != null) {
        newMap = searchParameters!.cuisines;
        newMap.update(cuisines.keys.first,
            (existingValue) => cuisines[cuisines.keys.first]!);
      } else if (diets != null) {
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
        sorting: newSortType ?? searchParameters!.sorting,
        matchTitle: matchTitle ?? searchParameters!.matchTitle,
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
    } catch (e) {
      throw 'Failed to updateState: $e';
    }
  }

  @override
  replaceState(SearchParameters newSearchParameters) {
    try {
      searchParameters = newSearchParameters;
    } catch (e) {
      throw 'Couldnt replace SearchParametersDatabase state with the new state: $e';
    }
  }

  @override
  resetToDefaults(String query) {
    try {
      searchParameters = SearchParameters(query: query);
    } catch (e) {
      throw 'Couldnt reset search parameters database to defaults: $e';
    }
  }
}
