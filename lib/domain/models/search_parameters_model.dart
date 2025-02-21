import 'package:flutter/material.dart';
import 'package:recipe_box/domain/enums.dart';

class SearchParameters {
  final String query;
  Map<MealType, AndOrType> meals;
  Map<CuisineType, RequireExclude> cuisines;
  Map<DietType, AndOrType> diets;
  Map<EquipmentType, AndOrType> equipment;
  Map<IntoleranceType, RequireExclude> intolerances;
  Map<String, RequireExclude> ingredients;
  final double maxTime;
  final RangeValues calories;
  final RangeValues servings;
  final RangeValues protein;
  final RangeValues fat;

  SearchParameters({
    this.query = '',
    Map<MealType, AndOrType>? meals,
    Map<CuisineType, RequireExclude>? cuisines,
    Map<DietType, AndOrType>? diets,
    Map<EquipmentType, AndOrType>? equipment,
    Map<IntoleranceType, RequireExclude>? intolerances,
    Map<String, RequireExclude>? ingredients,
    this.maxTime = 720,
    this.calories = const RangeValues(0, 1000),
    this.servings = const RangeValues(0, 100),
    this.protein = const RangeValues(0, 100),
    this.fat = const RangeValues(0, 100),
  })  : cuisines = cuisines ??
            Map.fromIterable(
              CuisineType.values,
              value: (_) => RequireExclude.unspecified,
            ),
        meals = meals ??
            Map.fromIterable(
              MealType.values,
              value: (_) => AndOrType.unspecified,
            ),
        diets = diets ??
            Map.fromIterable(
              DietType.values,
              value: (_) => AndOrType.unspecified,
            ),
        equipment = equipment ??
            Map.fromIterable(EquipmentType.values,
                value: (_) => AndOrType.unspecified),
        ingredients = ingredients ?? {'': RequireExclude.exclude},
        intolerances = intolerances ??
            Map.fromIterable(IntoleranceType.values,
                value: (_) => RequireExclude.unspecified);

  SearchParameters copyWith({
    String? query,
    Map<MealType, AndOrType>? meals,
    Map<CuisineType, RequireExclude>? cuisines,
    Map<DietType, AndOrType>? diets,
    Map<EquipmentType, AndOrType>? equipment,
    Map<IntoleranceType, RequireExclude>? intolerances,
    Map<String, RequireExclude>? ingredients,
    double? maxTime,
    RangeValues? calories,
    RangeValues? servings,
    RangeValues? protein,
    RangeValues? fat,
  }) {
    return SearchParameters(
      query: query ?? this.query,
      meals: meals ?? this.meals,
      cuisines: cuisines ?? this.cuisines,
      diets: diets ?? this.diets,
      equipment: equipment ?? this.equipment,
      intolerances: intolerances ?? this.intolerances,
      ingredients: ingredients ?? this.ingredients,
      maxTime: maxTime ?? this.maxTime,
      calories: calories ?? this.calories,
      servings: servings ?? this.servings,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
    );
  }
}
