import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:recipe_box/data/repositories/search_pramaters_repository.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class RecipeSearchService {
  RecipeSearchService();

  Future<dynamic> fetchRecipes(int offset, int numberOfRecipes,
      SearchParameters searchPramatersRepository) async {
    print('ran service ');

    try {
      const String appKey = '096cc91305b04684ab47dfebc84bc59e';

      final query = searchPramatersRepository.query;
      String selectedCuisines = searchPramatersRepository.selectedCuisines
          .map((cuisine) => cuisine.displayName)
          .join(',');
      String deselectedCuisines = searchPramatersRepository.deselectedCuisines
          .map((cuisine) => cuisine.displayName)
          .join(',');
      String dietsAndOr = searchPramatersRepository.dietAndOr.displayName;
      String requiredDiets = searchPramatersRepository.requiredDiets
          .map((diet) => diet.displayName)
          .join(dietsAndOr);
      String intolerances = searchPramatersRepository.intolerances
          .map((intolerance) => intolerance.displayName)
          .join(',');
      String queryParameters = 'query=${Uri.encodeComponent(query.trim())}&'
          'apiKey=$appKey&'
          'cuisine=$selectedCuisines&'
          'excludeCuisine=$deselectedCuisines&'
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
          'offset=$offset&'
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
