import 'package:recipe_box/domain/models/recipe_model.dart';

abstract class AbstractFavoritesRepository {
  Future<List<RecipeModel>> getFavorites();
  Future<void> addFavorite(RecipeModel newFavoriteRecipe);
  Future<void> removeFavorite(int oldFavoriteRecipeID);
  Future<bool> checkIfRecipeIsFavorite(int recipeID);
}
