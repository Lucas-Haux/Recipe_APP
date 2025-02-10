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
    double? maxCalories,
    double? minCalories,
    double? maxServings,
    double? minServings,
    double? maxProtein,
    double? minProtein,
    double? maxFat,
    double? minFat,
    Map<CuisineType, RequireExclude>? cuisines,
    Map<DietType, AndOrType>? diets,
    Map<IntoleranceType, RequireExclude>? intolerances,
  });

  resetToDefaults();
}
