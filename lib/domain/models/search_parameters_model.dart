import 'package:recipe_box/domain/enums.dart';

class SearchParameters {
  final String query;
  final Set<CuisineType> selectedCuisines;
  final Set<CuisineType> deselectedCuisines;
  final Set<DietType> requiredDiets;
  final AndOrType dietAndOr;
  final Set<IntoleranceType> intolerances;
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
    this.selectedCuisines = const {},
    this.deselectedCuisines = const {},
    this.requiredDiets = const {},
    this.dietAndOr = AndOrType.and,
    this.intolerances = const {},
    this.maxTime = 720,
    this.maxCalories = 1000,
    this.minCalories = 0,
    this.maxServings = 100,
    this.minServings = 0,
    this.maxProtein = 100,
    this.minProtein = 0,
    this.maxFat = 100,
    this.minFat = 0,
  });

  SearchParameters copyWith({
    String? query,
    Set<CuisineType>? selectedCuisines,
    Set<CuisineType>? deselectedCuisines,
    Set<DietType>? requiredDiets,
    AndOrType? dietAndOr,
    Set<IntoleranceType>? intolerances,
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
      selectedCuisines: selectedCuisines ?? this.selectedCuisines,
      deselectedCuisines: deselectedCuisines ?? this.deselectedCuisines,
      requiredDiets: requiredDiets ?? this.requiredDiets,
      dietAndOr: dietAndOr ?? this.dietAndOr,
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
