import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:recipe_box/data/repositories/search_pramaters_repository/search_pramaters_repository.dart';
import 'package:recipe_box/domain/enums.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class RecipeSearchService {
  RecipeSearchService();

  Future<dynamic> fetchRecipes(num offset, num numberOfRecipes,
      SearchParameters searchPramatersRepository) async {
    print('ran service ');

    try {
      const String appKey = '096cc91305b04684ab47dfebc84bc59e';

      final query = searchPramatersRepository.query;
      // For every cuisines in the map that is set to require add the cuisine display name to the string
      String includedcuisines = searchPramatersRepository.cuisines.keys
          .where((key) =>
              searchPramatersRepository.cuisines[key] == RequireExclude.require)
          .map((cuisines) => cuisines.displayName)
          .join(',');
      String excludedCuisines = searchPramatersRepository.cuisines.keys
          .where((key) =>
              searchPramatersRepository.cuisines[key] == RequireExclude.exclude)
          .map((cuisines) => cuisines.displayName)
          .join(',');

      AndOrType? dietsValue = searchPramatersRepository.diets.values
          .where((value) => value != AndOrType.unspecified)
          .cast<AndOrType?>()
          .firstWhere((_) => true, orElse: () => null);

      String requiredDiets = '';

      if (dietsValue != null) {
        print('diets Vaue $dietsValue');
        String? diestValueString;
        switch (dietsValue) {
          case AndOrType.or:
            diestValueString = '|';
          case AndOrType.and:
            diestValueString = ',';

          default:
        }

        requiredDiets = searchPramatersRepository.diets.keys
            .where((key) =>
                searchPramatersRepository.diets[key] != AndOrType.unspecified)
            .map((diets) => diets.displayName)
            .join(diestValueString!);
      }

      String intolerances = searchPramatersRepository.intolerances.keys
          .where((key) =>
              searchPramatersRepository.intolerances[key] ==
              RequireExclude.exclude)
          .map((intolerances) => intolerances.displayName)
          .join(',');

      // Combine all the parameters
      String queryParameters = 'query=${Uri.encodeComponent(query.trim())}&'
          'apiKey=$appKey&'
          // TODO this doenst acutally require all the cuisines, it requires the recipe to have one of the list. Need to change the UI and Enums to say include instead of required
          'cuisine=$includedcuisines&'
          'excludeCuisine=$excludedCuisines&'
          'diet=$requiredDiets&'
          'intolerances=$intolerances&'
          'maxReadyTime=${searchPramatersRepository.maxTime.toInt()}&'
          'maxServings=${searchPramatersRepository.maxServings.toInt()}&'
          'minServings=${searchPramatersRepository.minServings.toInt()}&'
          'maxCalories=${searchPramatersRepository.maxCalories.toInt()}&'
          'minCalories=${searchPramatersRepository.minCalories.toInt()}&'
          'maxProtein=${searchPramatersRepository.maxProtein.toInt()}&'
          'minProtein=${searchPramatersRepository.minProtein.toInt()}&'
          'maxFat=${searchPramatersRepository.maxFat.toInt()}&'
          'minFat=${searchPramatersRepository.minFat.toInt()}&'
          'fillIngredients=true&'
          'addRecipeInformation=true&'
          'addRecipeInstructions=true&'
          'instructionsRequired=true&'
          'addRecipeNutrition=true&'
          'offset=${offset.toInt()}&'
          'number=$numberOfRecipes&'
          'sort=popularity';

      // make uri with the api endpoint and parameters
      final Uri uri =
          Uri.parse('https://api.spoonacular.com/recipes/complexSearch')
              .replace(
        query: queryParameters,
      );
      print(uri);

      // call api
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      print('-----------');
      print('status code: ${response.statusCode}');
      print(
          'used tokens: ${response.headersSplitValues['x-api-quota-request']}');
      print('request ${response.request}');
      print('-----------');

      if (response.statusCode == 200) {
        final recipeResponseData = jsonDecode(utf8.decode(response.bodyBytes));

        return recipeResponseData;
        // Handle the response recipeResponseData
      } else {
        throw 'api response != 200: ${response.reasonPhrase}';
      }
    } catch (e) {
      print(e);
      throw 'Couldnt get response from API: $e';
    }
  }
}
