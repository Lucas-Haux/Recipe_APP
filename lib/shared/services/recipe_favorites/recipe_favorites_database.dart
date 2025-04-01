import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_box/shared/models/recipe.dart';

part 'recipe_favorites_database.g.dart';

abstract class AbstractFavoritesDatabase {
  Future<List<Recipe>> getFavorites();
  Future<Recipe> getSingleRecipe(int recipeListIndex);
  Future<void> addFavorite(Recipe newFavoriteRecipe);
  Future<void> removeFavorite(int oldFavoriteRecipeID);
  Future<bool> checkIfRecipeIsFavorite(int recipeID);
}

@Riverpod(keepAlive: true)
AbstractFavoritesDatabase favoritesDatabase(Ref ref) =>
    LocalFavoritesDatabase();

class LocalFavoritesDatabase implements AbstractFavoritesDatabase {
  late Future<Isar> favoritesDatabase;

  LocalFavoritesDatabase() {
    favoritesDatabase = openDB();
  }

  @override
  Future<List<Recipe>> getFavorites() async {
    try {
      final isar = await favoritesDatabase;

      final favorites = isar.recipes.where().findAll();
      return favorites;
    } catch (e) {
      throw "Cant return favorites from database: $e";
    }
  }

  @override
  Future<Recipe> getSingleRecipe(int recipeId) async {
    try {
      final isar = await favoritesDatabase;

      final recipe =
          await isar.recipes.filter().recipeIdEqualTo(recipeId).findFirst();
      print(recipeId);

      print(recipe == null);

      return recipe!;
    } catch (e) {
      throw 'Failed to get single recipe from database: $e';
    }
  }

  @override
  Future<void> addFavorite(Recipe newFavoriteRecipe) async {
    try {
      final isar = await favoritesDatabase;

      // genereate a recipe this way so it has a unique id
      final recipe = Recipe(
        recipeId: newFavoriteRecipe.recipeId,
        title: newFavoriteRecipe.title,
        imageUrl: newFavoriteRecipe.imageUrl,
        sourceName: newFavoriteRecipe.sourceName,
        sourceUrl: newFavoriteRecipe.sourceUrl,
        popular: newFavoriteRecipe.popular,
        vegetarian: newFavoriteRecipe.vegetarian,
        vegan: newFavoriteRecipe.vegan,
        cuisines: newFavoriteRecipe.cuisines,
        dishTypes: newFavoriteRecipe.dishTypes,
        diets: newFavoriteRecipe.diets,
        time: newFavoriteRecipe.time,
        servings: newFavoriteRecipe.servings,
        pricePerServing: newFavoriteRecipe.pricePerServing,
        healthScore: newFavoriteRecipe.healthScore,
        weightWatcher: newFavoriteRecipe.weightWatcher,
        calories: newFavoriteRecipe.calories,
        protein: newFavoriteRecipe.protein,
        fat: newFavoriteRecipe.fat,
        summary: newFavoriteRecipe.summary,
        ingredients: newFavoriteRecipe.ingredients,
        nutrients: newFavoriteRecipe.nutrients,
        similarRecipes: newFavoriteRecipe.similarRecipes,
        instructionsParagraph: newFavoriteRecipe.instructionsParagraph,
        instructions: newFavoriteRecipe.instructions,
      );

      await isar.writeTxn(() async {
        isar.recipes.put(recipe);
      });
    } catch (e) {
      throw "Failed to add favorite to database: $e";
    }
  }

  @override
  Future<void> removeFavorite(int oldFavoriteRecipeID) async {
    try {
      final isar = await favoritesDatabase;

      final recipe = await isar.recipes
          .filter()
          .recipeIdEqualTo(oldFavoriteRecipeID)
          .findFirst();

      if (recipe == null) throw "Cant find recipe with provided id";

      await isar.writeTxn(() async {
        isar.recipes.delete(recipe.id!);
      });
    } catch (e) {
      throw "Failed to add favorite to database: $e";
    }
  }

  @override
  Future<bool> checkIfRecipeIsFavorite(int recipeID) async {
    try {
      final isar = await favoritesDatabase;

      final Recipe? recipe =
          await isar.recipes.filter().recipeIdEqualTo(recipeID).findFirst();
      return (recipe != null) ? true : false;
    } catch (e) {
      throw "Failed to check if favorite is in database: $e";
    }
  }

  Future<Isar> openDB() async {
    try {
      if (Isar.instanceNames.contains("favoritesDatabase")) {
        return Future.value(Isar.getInstance("favoritesDatabase"));
      } else {
        final docs = await getApplicationDocumentsDirectory();
        // TODO this should be somewhere in share
        final favoriteRecipesDir = Directory('${docs.path}/favoritesDatabase');
        await favoriteRecipesDir.create(recursive: true);

        return Isar.openSync(
          [RecipeSchema],
          name: "favoritesDatabase",
          directory: favoriteRecipesDir.path,
          inspector: true,
        );
      }
    } catch (e) {
      throw 'fail to open favorites database: $e';
    }
  }

  Future<void> clearDB() async {
    try {
      final isar = await favoritesDatabase;

      // dont clear if database is empty
      if (await isar.recipes.count() > 0) {
        await isar.writeTxn(() async {
          await isar.clear();
        });
      }
    } catch (e) {
      throw 'failed to clear favorites database: $e';
    }
  }
}
