import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:recipe_box/data/repositories/search_pramaters_repository.dart';

class RecipeSearchService {
  RecipeSearchService();

  Future<dynamic> fetchRecipes() async {
    final searchPramatersRepository = SearchPramatersRepository().debugState;

    try {
      const String appKey = '1f9d617ba13041859ea773423b0e6291';

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
          'number=30&'
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
      throw 'Couldnt get response from API: $e';
    }
  }
}
