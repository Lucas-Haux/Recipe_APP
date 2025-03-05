import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:recipe_box/data/repositories/favorites_repository/abstract_favorites_repository.dart';
import 'package:recipe_box/domain/models/recipe_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_repository.g.dart';

@Riverpod(keepAlive: true)
AbstractFavoritesRepository favoritesRepository(Ref ref) =>
    LocalFavoritesRepository();

class LocalFavoritesRepository implements AbstractFavoritesRepository {
  late Future<Isar> favoritesDataBase;

  LocalFavoritesRepository() {
    favoritesDataBase = openDB();
  }
  @override
  Future<List<RecipeModel>> getFavorites() async {
    try {
      final isar = await favoritesDataBase;

      return isar.recipeModels.where().findAll();
    } catch (e) {
      throw "Cant get favorites in repo $e";
    }
  }

  @override
  Future<void> addFavorite(RecipeModel newFavoriteRecipe) async {
    try {
      final isar = await favoritesDataBase;

      await isar.writeTxn(() async {
        isar.recipeModels.put(newFavoriteRecipe);
      });
      print("i add");

      print(await checkIfRecipeIsFavorite(newFavoriteRecipe.recipeId));
    } catch (e) {
      throw "Failed to add favorite $e";
    }
  }

  @override
  Future<void> removeFavorite(int oldFavoriteRecipeID) async {
    try {
      final isar = await favoritesDataBase;

      final recipe = await isar.recipeModels
          .filter()
          .recipeIdEqualTo(oldFavoriteRecipeID)
          .findFirst();

      if (recipe == null) throw "Cant find recipe with that id";

      await isar.writeTxn(() async {
        isar.recipeModels.delete(recipe.id!);
      });
      print("i remove");
      print(await checkIfRecipeIsFavorite(oldFavoriteRecipeID));
    } catch (e) {
      throw "Failed to add favorite $e";
    }
  }

  @override
  Future<bool> checkIfRecipeIsFavorite(int recipeID) async {
    try {
      print('!!!!!!!!!!!!!!!!!!');

      final isar = await favoritesDataBase;
      print('!!!!!!!!!!!!!!!!!!');

      final test = await isar.recipeModels
          .filter()
          .recipeIdEqualTo(recipeID)
          .findFirst();
      print("???????????????????????");
      return (test != null) ? true : false;
    } catch (e) {
      throw "Failed to check if favorite in repo $e";
    }
  }

  Future<Isar> openDB() async {
    try {
      if (Isar.instanceNames.contains("favoritesDataBase")) {
        print("found db");
        return Future.value(Isar.getInstance("favoritesDataBase"));
      } else {
        print("no found db");

        final docs = await getApplicationDocumentsDirectory();
        print("here?");

        final favoriteRecipesDir = Directory('${docs.path}/favoriteRecipes');
        await favoriteRecipesDir.create(recursive: true);
        print("here?");

        return Isar.openSync(
          [RecipeModelSchema],
          name: "favoritesDataBase",
          directory: favoriteRecipesDir.path,
          inspector: true,
        );
      }
    } catch (e) {
      throw 'fail to open DB $e';
    }
  }

  Future<void> clearDB() async {
    try {
      final isar = await favoritesDataBase;

      if (await isar.recipeModels.count() > 0) {
        await isar.writeTxn(() async {
          await isar.clear();
        });
      }
    } catch (e) {
      throw 'failed to clearDB: $e';
    }
  }
}
