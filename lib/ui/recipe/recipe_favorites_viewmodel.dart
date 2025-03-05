import 'package:recipe_box/data/repositories/favorites_repository/favorites_repository.dart';
import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_favorites_viewmodel.g.dart';

@riverpod
class RecipeFavoritesViewmodel extends _$RecipeFavoritesViewmodel {
  @override
  FutureOr<bool?> build(RecipeModel? recipe) async {
    try {
      if (recipe == null) return null;

      return ref
          .watch(favoritesRepositoryProvider)
          .checkIfRecipeIsFavorite(recipe.recipeId);
    } catch (e) {
      throw "Failed to build recipe_viewmodel $e";
    }
  }

  Future<void> addFavorite() async {
    try {
      await ref.read(favoritesRepositoryProvider).addFavorite(recipe!);
      state = AsyncValue.data(await ref
          .read(favoritesRepositoryProvider)
          .checkIfRecipeIsFavorite(recipe!.recipeId));
    } catch (e) {
      throw "Failed to add favorite in view model $e";
    }
  }

  Future<void> removeFavorite() async {
    try {
      await ref
          .read(favoritesRepositoryProvider)
          .removeFavorite(recipe!.recipeId);
      state = AsyncValue.data(await ref
          .read(favoritesRepositoryProvider)
          .checkIfRecipeIsFavorite(recipe!.recipeId));
    } catch (e) {
      throw "Failed to remove favorite in view model $e";
    }
  }
}
