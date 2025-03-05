import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_box/data/model/recipe_search_data_model.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../data/services/recipe_search_service.dart';
import '../../../data/services/similar_recipe_service.dart';
import '../../../data/services/recipe_full_info_service.dart';
import '../../../domain/models/recipe_model.dart';
import 'dart:async';
import 'abstract_recipe_data_repository.dart';

part 'recipe_data_repository.g.dart';

@Riverpod(keepAlive: false)
AbstractRecipeDataRepository recipeDataRepository(Ref ref) =>
    LocalRecipeDataRepository();

class LocalRecipeDataRepository implements AbstractRecipeDataRepository {
  late Future<Isar> recipeDataBase;

  LocalRecipeDataRepository() {
    recipeDataBase = openDB();
  }

  @override
  Future<List<RecipeModel>> getRecipes() async {
    try {
      final isar = await recipeDataBase;

      final recipe = await isar.recipeModels.where().findAll();
      return recipe;
    } catch (e) {
      throw RecipeException('Failed to get Recipes', e);
    }
  }

  @override
  Future<RecipeModel> getSingleRecipe(int recipeListIndex) async {
    try {
      print('ran this');
      final isar = await recipeDataBase;
      print('got box');

      final recipes = await isar.recipeModels.where().findAll();

      return recipes[recipeListIndex];
    } catch (e) {
      throw RecipeException('Failed to get single recipe', e);
    }
  }

  @override
  Future<RecipeSearchDataModel> searchForRecipes(
    num pageNumber,
    num size,
    SearchParameters searchParamaters,
  ) async {
    try {
      final isar = await recipeDataBase;

      final num offset = pageNumber.toDouble() * size;

      //Get Api Response
      final response = await RecipeSearchService()
          .fetchRecipes(offset, size, searchParamaters);

      //Convert to List<RecipeModel>
      final results = response['results'] as List<dynamic>;
      List<RecipeModel> recipes = results
          .map<RecipeModel>((jsonMap) => RecipeModel.fromJson(jsonMap))
          .toList();

      //Add List to DataBase
      await isar.writeTxn(() async {
        await isar.recipeModels.putAll(recipes);
      });

      print("88888888888888888888888 HERE 88888888888888888888888");

      RecipeSearchDataModel recipeSearchDataModel = RecipeSearchDataModel(
        recipeData: recipes,
        totalResults: response['totalResults'],
        usedTokens: response['usedTokens'],
      );

      print('it works :)))');

      return recipeSearchDataModel;
    } catch (e, stackTrace) {
      debugPrint('$stackTrace');
      throw RecipeException('Error searching for recipe: ', e, stackTrace);
    }
  }

  @override
  Future<void> replaceRecipeDataWithFullData(int index) async {
    try {
      final isar = await recipeDataBase;

      // Get Api Response
      final jsonResponse = await RecipeFullInfoService()
          .fetchFullRecipe(isar.recipeModels.getSync(index)!.recipeId);
      // Convert to new RecipeModel
      RecipeModel newRecipe = RecipeModel.fromJson(
        jsonResponse,
      );

      // Replace Recipe with new recipe in database
      await isar.writeTxnSync(() async {
        newRecipe.id = index;
        isar.recipeModels.putSync(newRecipe);
      });
    } catch (e) {
      throw RecipeException('Error replacing recipe data:', e);
    }
  }

  @override
  Future<void> addSimilarRecipesToRecipe(int index) async {
    try {
      final isar = await recipeDataBase;

      final jsonResponse = await SimilarRecipeService()
          .fetchSimilarRecipes(isar.recipeModels.getSync(index)!.recipeId);

      // get list of similarRecipes from json response
      List<SimilarRecipeModel> similarRecipes = [];
      for (var recipe in jsonResponse) {
        similarRecipes.add(SimilarRecipeModel.fromJson(recipe));
      }

      final RecipeModel? newRecipe =
          await isar.recipeModels.where().idEqualTo(index).findFirst();

      if (newRecipe != null) {
        await isar.writeTxnSync(() async {
          newRecipe.similarRecipes = similarRecipes;
          isar.recipeModels.putSync(newRecipe);
        });
      } else {
        throw "cant find recipe with id";
      }

      // Replace Recipe with new recipe in database
    } catch (e, stackTrace) {
      throw RecipeException('Error adding  Similar recipes:', e, stackTrace);
    }
  }

  Future<Isar> openDB() async {
    try {
      if (Isar.instanceNames.contains("RecipeSearchDataBase")) {
        return Future.value(Isar.getInstance("RecipeSearchDataBase"));
      } else {
        return Isar.openSync(
          [RecipeModelSchema],
          name: "RecipeSearchDataBase",
          directory: (await getApplicationDocumentsDirectory()).path,
          inspector: true,
        );
      }
    } catch (e) {
      throw 'fail to open DB $e';
    }
  }

  @override
  Future<void> clearDB() async {
    try {
      final isar = await recipeDataBase;

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
