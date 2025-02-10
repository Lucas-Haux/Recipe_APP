import 'package:recipe_box/domain/enums.dart';

class SearchParameters {
  final String query;
  Map<CuisineType, RequireExclude> cuisines;
  Map<DietType, AndOrType> diets;
  Map<IntoleranceType, RequireExclude> intolerances;
  final double maxTime;
  final double maxCalories;
  final double minCalories;
  final double maxServings;
  final double minServings;
  final double maxProtein;
  final double minProtein;
  final double maxFat;
  final double minFat;

  SearchParameters({
    this.query = '',
    Map<CuisineType, RequireExclude>? cuisines,
    Map<DietType, AndOrType>? diets,
    Map<IntoleranceType, RequireExclude>? intolerances,
    this.maxTime = 720,
    this.maxCalories = 1000,
    this.minCalories = 0,
    this.maxServings = 100,
    this.minServings = 0,
    this.maxProtein = 100,
    this.minProtein = 0,
    this.maxFat = 100,
    this.minFat = 0,
  })  : cuisines = cuisines ??
            Map.fromIterable(
              CuisineType.values,
              value: (_) => RequireExclude.unspecified,
            ),
        diets = diets ??
            Map.fromIterable(
              DietType.values,
              value: (_) => AndOrType.unspecified,
            ),
        intolerances = intolerances ??
            Map.fromIterable(IntoleranceType.values,
                value: (_) => RequireExclude.unspecified);

  SearchParameters copyWith({
    String? query,
    Map<CuisineType, RequireExclude>? cuisines,
    Map<DietType, AndOrType>? diets,
    Map<IntoleranceType, RequireExclude>? intolerances,
    double? maxTime,
    double? maxCalories,
    double? minCalories,
    double? maxServings,
    double? minServings,
    double? maxProtein,
    double? minProtein,
    double? maxFat,
    double? minFat,
  }) {
    return SearchParameters(
      query: query ?? this.query,
      cuisines: cuisines ?? this.cuisines,
      diets: diets ?? this.diets,
      intolerances: intolerances ?? this.intolerances,
      maxTime: maxTime ?? this.maxTime,
      maxCalories: maxCalories ?? this.maxCalories,
      minCalories: minCalories ?? this.minCalories,
      maxServings: maxServings ?? this.maxServings,
      minServings: minServings ?? this.minServings,
      maxProtein: maxProtein ?? this.maxProtein,
      minProtein: minProtein ?? this.minProtein,
      maxFat: maxFat ?? this.maxFat,
      minFat: minFat ?? this.minProtein,
    );
  }
}
