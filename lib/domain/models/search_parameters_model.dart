import 'package:recipe_box/domain/enums.dart';

class SearchParameters {
  final String query;
  final Set<CuisineType> selectedCuisines;
  final Set<CuisineType> deselectedCuisines;
  final Set<DietType> requiredDiets;
  final AndOrType dietAndOr;
  final Set<IntoleranceType> intolerances;

  SearchParameters({
    this.query = '',
    this.selectedCuisines = const {},
    this.deselectedCuisines = const {},
    this.requiredDiets = const {},
    this.dietAndOr = AndOrType.and,
    this.intolerances = const {},
  });

  SearchParameters copyWith({
    String? query,
    Set<CuisineType>? selectedCuisines,
    Set<CuisineType>? deselectedCuisines,
    Set<DietType>? requiredDiets,
    AndOrType? dietAndOr,
    Set<IntoleranceType>? intolerances,
  }) {
    return SearchParameters(
      query: query ?? this.query,
      selectedCuisines: selectedCuisines ?? this.selectedCuisines,
      deselectedCuisines: deselectedCuisines ?? this.deselectedCuisines,
      requiredDiets: requiredDiets ?? this.requiredDiets,
      dietAndOr: dietAndOr ?? this.dietAndOr,
      intolerances: intolerances ?? this.intolerances,
    );
  }
}
