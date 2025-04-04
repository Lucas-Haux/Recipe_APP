import 'package:recipe_box/shared/models/recipe.dart';

class RecipeSearchResult {
  final List<Recipe> recipeData;
  final int totalResults;
  double usedTokens;

  RecipeSearchResult({
    required this.recipeData,
    required this.totalResults,
    required this.usedTokens,
  });
}
