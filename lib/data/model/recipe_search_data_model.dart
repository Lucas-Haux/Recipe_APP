import 'package:recipe_box/domain/models/recipe_model.dart';

class RecipeSearchDataModel {
  final List<RecipeModel> recipeData;
  final int totalResults;
  double usedTokens;

  RecipeSearchDataModel({
    required this.recipeData,
    required this.totalResults,
    required this.usedTokens,
  });
}
