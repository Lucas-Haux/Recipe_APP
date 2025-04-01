import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/models/search_parameters.dart';
import 'package:recipe_box/shared/services/recipe_search_results/model/recipe_search_result.dart';
import 'package:recipe_box/shared/services/recipe_search_results/apis/recipe_data.dart';
import 'package:recipe_box/shared/services/recipe_search_results/apis/recipes_search.dart';
import 'package:recipe_box/shared/services/recipe_search_results/apis/similar_recipes.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

part 'recipe_search_results_database.g.dart';

abstract class AbstractRecipeSearchResultsDatabase {
  Future<RecipeSearchResult> searchForRecipes(
    num pageNumber,
    num size,
    SearchParameters searchParamaters,
  );

  Future<List<Recipe>> getRecipes();

  Future<Recipe> getSingleRecipe(int recipeListIndex);

  Future<void> replaceRecipeDataWithFullData(int recipeListIndex);

  Future<void> addSimilarRecipesToRecipe(int recipeListIndex);

  // todo Remove this, make clearDB() a local function. Have the dm clear when the page number is zero
  Future<void> clearDB();
}

@Riverpod(keepAlive: false)
AbstractRecipeSearchResultsDatabase recipeSearchResultsDatabase(Ref ref) =>
    _LocalRecipeSearchResultsDatabase();

class _LocalRecipeSearchResultsDatabase
    implements AbstractRecipeSearchResultsDatabase {
  late Future<Isar> recipeDatabase;

  _LocalRecipeSearchResultsDatabase() {
    recipeDatabase = _openDB();
  }

  @override
  Future<List<Recipe>> getRecipes() async {
    try {
      final isar = await recipeDatabase;

      final recipe = await isar.recipes.where().findAll();
      return recipe;
    } catch (e) {
      throw 'Failed to get Recipes from database: $e';
    }
  }

  //@override
  //Future<Recipe> getSingleRecipe(int recipeListIndex) async {
  //  try {
  //    final isar = await recipeDatabase;
  //
  //    final recipes = await isar.recipes.where().findAll();
  //
  //    return recipes[recipeListIndex];
  //  } catch (e) {
  //    throw 'Failed to get single recipe from database: $e';
  //  }
  //}
  //

  @override
  Future<Recipe> getSingleRecipe(int recipeId) async {
    try {
      final isar = await recipeDatabase;

      final Recipe recipe = await isar.recipes
          .filter()
          .recipeIdEqualTo(recipeId)
          .findFirst() as Recipe;

      return recipe;
    } catch (e) {
      throw 'Failed to get single recipe from database: $e';
    }
  }

  @override
  Future<RecipeSearchResult> searchForRecipes(
    num pageNumber,
    num size,
    SearchParameters searchParamaters,
  ) async {
    try {
      final isar = await recipeDatabase;

      final num offset = pageNumber.toDouble() * size;

      //Get Api Response
      final response =
          await RecipesSearch().fetchRecipes(offset, size, searchParamaters);

      //Convert to List<Recipe>
      final results = response['results'] as List<dynamic>;
      List<Recipe> recipes =
          results.map<Recipe>((jsonMap) => Recipe.fromJson(jsonMap)).toList();

      //Add List to DataBase
      await isar.writeTxn(() async {
        await isar.recipes.putAll(recipes);
      });

      RecipeSearchResult recipeSearchDataModel = RecipeSearchResult(
        recipeData: recipes,
        totalResults: response['totalResults'],
        usedTokens: response['usedTokens'],
      );
      return recipeSearchDataModel;
    } catch (e, stackTrace) {
      debugPrint('$stackTrace');
      throw 'Error searching for recipe in database: $e ';
    }
  }

  @override
  Future<void> replaceRecipeDataWithFullData(int index) async {
    try {
      final isar = await recipeDatabase;

      // Get Api Response
      final jsonResponse = await RecipeData()
          .fetchFullRecipe(isar.recipes.getSync(index)!.recipeId);
      // Convert to new Recipe
      Recipe newRecipe = Recipe.fromJson(
        jsonResponse,
      );

      // Replace Recipe with new recipe in database
      await isar.writeTxnSync(() async {
        newRecipe.id = index;
        isar.recipes.putSync(newRecipe);
      });
    } catch (e) {
      throw 'Error replacing recipe data in recipe database: $e';
    }
  }

  @override
  Future<void> addSimilarRecipesToRecipe(int index) async {
    try {
      final isar = await recipeDatabase;

      final jsonResponse = await SimilarRecipes()
          .fetchSimilarRecipes(isar.recipes.getSync(index)!.recipeId);

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
          newRecipe!.id = index;
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

  Future<Isar> _openDB() async {
    try {
      if (Isar.instanceNames.contains("RecipeSearchResultsDatabase")) {
        return Future.value(Isar.getInstance("RecipeSearchResultsDatabase"));
      } else {
        return Isar.openSync(
          [RecipeSchema],
          name: "RecipeSearchResultsDatabase",
          directory: (await getApplicationDocumentsDirectory()).path,
          inspector: true,
        );
      }
    } catch (e) {
      throw 'fail to open recipe database: $e';
    }
  }

  @override
  // TODO make local
  Future<void> clearDB() async {
    try {
      final isar = await recipeDatabase;

      if (isar.recipes.countSync() > 0) {
        isar.writeTxn(() async {
          await isar.clear();
        });
      }
    } catch (e) {
      throw 'failed to recipe database: $e';
    }
  }
}
