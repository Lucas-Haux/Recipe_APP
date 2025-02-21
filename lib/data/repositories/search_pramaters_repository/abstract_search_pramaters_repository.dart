import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/domain/enums.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';

class SearchParametersException implements Exception {
  final String message;
  final dynamic error;

  SearchParametersException(this.message, [this.error]);

  @override
  String toString() =>
      'SearchParametersException: $message${error != null ? ' ($error)' : ''}';
}

abstract class AbstractSearchParamatersRepository {
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
  });

  resetToDefaults();
}
