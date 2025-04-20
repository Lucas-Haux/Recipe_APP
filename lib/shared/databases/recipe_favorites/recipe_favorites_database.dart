import 'dart:io';

import 'package:recipe_box/shared/services/remote/recipe_data.dart';
import 'package:recipe_box/shared/services/remote/similar_recipes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_box/shared/models/recipe.dart';

part 'recipe_favorites_database.g.dart';

abstract class AbstractFavoritesDatabase {
  Future<List<Recipe>> getFavorites();
  Future<Recipe> getSingleRecipe(int recipeListIndex);
  Future<void> updateOrAddRecipe(Recipe recipe);
  Future<void> addFavorite(Recipe newFavoriteRecipe);
  Future<void> removeFavorite(int oldFavoriteRecipeID);
  Future<bool> checkIfRecipeIsFavorite(int recipeID);
  Future<void> replaceRecipeDataWithFullData(int recipeListIndex);
  Future<void> addSimilarRecipesToRecipe(int recipeListIndex);
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
  Future<Recipe> getSingleRecipe(int id) async {
    try {
      final isar = await favoritesDatabase;

      final recipe = await isar.recipes.filter().idEqualTo(id).findFirst();

      return recipe!;
    } catch (e) {
      throw 'Failed to get single recipe from database: $e';
    }
  }

  @override
  Future<void> updateOrAddRecipe(Recipe recipe) async {
    try {
      final isar = await favoritesDatabase;

      await isar.writeTxnSync(() async {
        isar.recipes.putSync(recipe);
      });
    } catch (e) {
      throw 'Failed to update or add recipe to recipe favoritesDatabase database: $e';
    }
  }

  @override
  Future<void> addFavorite(Recipe newFavoriteRecipe) async {
    try {
      final isar = await favoritesDatabase;

      // genereate a recipe this way so it has a unique id
      final recipe = Recipe(
        id: newFavoriteRecipe.id,
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
          .idEqualTo(oldFavoriteRecipeID)
          .findFirst();

      if (recipe == null) throw "Cant find recipe with provided id";

      await isar.writeTxn(() async {
        isar.recipes.delete(recipe.id);
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
          await isar.recipes.filter().idEqualTo(recipeID).findFirst();
      return (recipe != null) ? true : false;
    } catch (e) {
      throw "Failed to check if favorite is in database: $e";
    }
  }

  @override
  Future<void> replaceRecipeDataWithFullData(int index) async {
    try {
      final isar = await favoritesDatabase;

      // Get Api Response
      final jsonResponse =
          await RecipeData().fetchFullRecipe(isar.recipes.getSync(index)!.id);
      // Convert to new Recipe
      Recipe newRecipe = Recipe.fromJson(
        jsonResponse,
      );

      // Replace Recipe with new recipe in database
      await isar.writeTxnSync(() async {
        isar.recipes.putSync(newRecipe);
      });
    } catch (e) {
      throw 'Error replacing recipe data in favorites database: $e';
    }
  }

  @override
  Future<void> addSimilarRecipesToRecipe(int index) async {
    try {
      final isar = await favoritesDatabase;

      final jsonResponse =
          await fetchSimilarRecipes(isar.recipes.getSync(index)!.id);

      // get list of similarRecipes from json response
      List<SimilarRecipe> similarRecipes = [];
      for (var recipe in jsonResponse) {
        similarRecipes.add(SimilarRecipe.fromJson(recipe));
      }

      Recipe? newRecipe =
          await isar.recipes.where().idEqualTo(index).findFirst();

      if (newRecipe != null) {
        newRecipe = newRecipe.copyWith(similarRecipes: similarRecipes);

        await isar.writeTxnSync(() async {
          isar.recipes.putSync(newRecipe!);
        });
      } else {
        throw "cant find recipe with id in database";
      }

      // Replace Recipe with new recipe in database
    } catch (e, stackTrace) {
      throw 'Error adding  Similar recipes to database: $e $stackTrace';
    }
  }

  Future<Isar> openDB() async {
    try {
      if (Isar.instanceNames.contains("favoritesDatabase")) {
        return Future.value(Isar.getInstance("favoritesDatabase"));
      } else {
        final dir = await getExternalStorageDirectory();
        final favoriteRecipesDir = Directory('${dir!.path}/favoritesDatabase');
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
}
