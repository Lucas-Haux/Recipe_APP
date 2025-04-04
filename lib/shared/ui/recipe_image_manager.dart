import 'package:recipe_box/shared/databases/recipe_favorites/recipe_favorites_database.dart';
import 'package:recipe_box/shared/models/recipe.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_image_manager.g.dart';

@Riverpod()
class RecipeImageManager extends _$RecipeImageManager {
  @override
  FutureOr<bool?> build(Recipe? recipe) async {
    try {
      if (recipe == null) return null;

      return ref
          .watch(favoritesDatabaseProvider)
          .checkIfRecipeIsFavorite(recipe.id);
    } catch (e) {
      throw "Failed to build recipe image manager: $e";
    }
  }

  Future<void> addFavorite() async {
    try {
      await ref.read(favoritesDatabaseProvider).addFavorite(recipe!);
      state = AsyncValue.data(await ref
          .read(favoritesDatabaseProvider)
          .checkIfRecipeIsFavorite(recipe!.id));
    } catch (e) {
      throw "Failed to add favorite in recipe image manager: $e";
    }
  }

  Future<void> removeFavorite() async {
    try {
      await ref.read(favoritesDatabaseProvider).removeFavorite(recipe!.id);
      state = AsyncValue.data(await ref
          .read(favoritesDatabaseProvider)
          .checkIfRecipeIsFavorite(recipe!.id));
    } catch (e) {
      throw "Failed to remove favorite recipe image manager: $e";
    }
  }
}
