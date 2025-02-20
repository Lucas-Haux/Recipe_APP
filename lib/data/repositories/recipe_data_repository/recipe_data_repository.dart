import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
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
  Future<List<RecipeModel>> searchForRecipes(
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
        isar.recipeModels.putAll(recipes);
      });
      return recipes;
    } catch (e, stackTrace) {
      debugPrint('$stackTrace');
      throw e;
      // throw RecipeException('Error searching for recipe: ', e, stackTrace);
    }
  }

  @override
  Future<void> replaceRecipeData(int recipeListIndex) async {
    try {
      final isar = await recipeDataBase;

      // Get Api Response
      final jsonResponse = await RecipeFullInfoService().fetchFullRecipe(
          isar.recipeModels.getSync(recipeListIndex)!.recipeId);
      // Convert to new RecipeModel
      final newRecipe = RecipeModel.fromJson(jsonResponse);

      // Replace Recipe with new recipe in database
      await isar.writeTxn(() async {
        isar.recipeModels.putByIndexSync(recipeListIndex.toString(), newRecipe);
      });
    } catch (e) {
      throw RecipeException('Error replacing recipe data:', e);
    }
  }

  @override
  Future<void> addSimilarRecipesToRecipe(int recipeListIndex) async {
    try {
      final isar = await recipeDataBase;

      // Get Api Response
      final jsonResponse = await SimilarRecipeService().fetchSimilarRecipes(
          isar.recipeModels.getSync(recipeListIndex)!.recipeId);
      // Convert to Lists<SimilarRecipeModel>
      final List<SimilarRecipeModel> similarRecipes =
          SimilarRecipeModel.fromJson(jsonResponse) as List<SimilarRecipeModel>;

      // Get the current recipe of recipeListIndex
      final RecipeModel? oldRecipe =
          await isar.recipeModels.get(recipeListIndex);
      // make new RecipeModel thats clones oldRecipe with new similarRecipes
      final RecipeModel newRecipe =
          oldRecipe!.copyWith(similarRecipes: similarRecipes);

      // Replace Recipe with new recipe in database
      await isar.writeTxn(() async {
        isar.recipeModels.putByIndexSync(recipeListIndex.toString(), newRecipe);
      });
    } catch (e) {
      throw RecipeException('Error adding  Similar recipes:', e);
    }
  }

  Future<Isar> openDB() async {
    try {
      if (Isar.instanceNames.isEmpty) {
        return await Isar.open([RecipeModelSchema],
            directory: (await getApplicationDocumentsDirectory()).path,
            inspector: true);
      }

      return Future.value(Isar.getInstance());
    } catch (e) {
      throw 'fail to open DB $e';
    }
  }

  @override
  Future<void> clearDB() async {
    try {
      final isar = await recipeDataBase;
      await isar.writeTxn(() => isar.clear());
      await openDB();
    } catch (e) {
      throw 'failed to clearDB: $e';
    }
  }
}
