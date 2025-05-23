import 'package:flutter/material.dart';
import 'package:recipe_box/shared/databases/searchs-parameters/search_parameters_database.dart';

import 'package:recipe_box/shared/models/search_parameters.dart';
import 'package:recipe_box/shared/enums/recipe_parameters.dart';
import 'package:recipe_box/shared/enums/chip_parameters_modes.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'popular_searches_manager.g.dart';

@riverpod
class PopularSearchesManager<RecipeParameter extends DisplayableEnum,
        ParameterValue extends ChipParametersMode>
    extends _$PopularSearchesManager {
  @override
  void build() {}

  void setFilters(SearchParameters searchParameters) async {
    try {
      SearchParameters fullSearchParameters = SearchParameters();

      fullSearchParameters = fullSearchParameters.copyWith(
        query: searchParameters.query,
        maxTime: searchParameters.maxTime,
        protein: searchParameters.protein,
        sorting: searchParameters.sorting,
      );
      fullSearchParameters.diets.addAll(searchParameters.diets);
      fullSearchParameters.cuisines.addAll(searchParameters.cuisines);
      fullSearchParameters.meals.addAll(searchParameters.meals);
      fullSearchParameters.equipment.addAll(searchParameters.equipment);
      fullSearchParameters.intolerances.addAll(searchParameters.intolerances);

      print(fullSearchParameters.query);

      ref
          .watch(searchParametersDatabaseProvider)
          .replaceState(fullSearchParameters);

      print(
          ' new state query == ${ref.read(searchParametersDatabaseProvider).getSearchParameters().query}');
    } catch (e) {
      throw 'Manager Couldnt setFilters: $e';
    }
  }
}

Map<String, SearchParameters> popularSearchesData = {
  'Quick 30-Minute Dinners': SearchParameters(
    query: 'Dinner',
    meals: {MealType.mainCourse: AndOrType.and},
    sorting: SortType.popularity,
    maxTime: 30,
  ),
  'Dairy-Free Smoothies': SearchParameters(
    query: 'Smoothie',
    meals: {MealType.beverage: AndOrType.and},
    intolerances: {IntoleranceType.dairy: RequireExclude.exclude},
  ),
  'Vegan Soups': SearchParameters(
    query: 'Soup',
    diets: {DietType.vegan: AndOrType.and},
    meals: {MealType.soup: AndOrType.and},
    matchTitle: true,
  ),
  'Nut-Free Snacks': SearchParameters(
    query: 'Snack',
    meals: {MealType.snack: AndOrType.and},
    intolerances: {
      IntoleranceType.peanut: RequireExclude.exclude,
      IntoleranceType.treeNut: RequireExclude.exclude
    },
  ),
  'High-Protein Breakfast': SearchParameters(
    query: 'Breakfast',
    protein: RangeValues(15, 100),
    meals: {MealType.breakfast: AndOrType.and},
  ),
};

Map<String, String> popularSearchesImages = {
  'Quick 30-Minute Dinners': 'assets/images/quick_30-min_dinners.jpg',
  'Dairy-Free Smoothies': 'assets/images/dairy-free_smoothies.jpg',
  'Vegan Soups': 'assets/images/vegan_soups.jpg',
  'Nut-Free Snacks': 'assets/images/vegan_cupcakes.jpg',
  'High-Protein Breakfast': 'assets/images/high-protein_breakfast.jpg',
};
