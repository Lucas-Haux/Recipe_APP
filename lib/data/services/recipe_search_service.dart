import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:recipe_box/data/repositories/search_pramaters_repository.dart';
import 'package:recipe_box/domain/enums.dart';

class RecipeSearchService {
  final Ref ref; // Dependency Injection for Ref

  RecipeSearchService(this.ref);

  Future<dynamic> fetchRecipes() async {
    final searchPramatersRepository =
        ref.read(searchPramatersRepositoryProvider);

    try {
      const String appKey = '05f5c84cb98f42329f13b049c9f05f5a';

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
          'fillIngredients=true&'
          'addRecipeInformation=true&'
          'instructionsRequired=true&'
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
        final recipeResponseData = jsonDecode(response.body);

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

final recipeSearchServiceProvider = Provider((ref) {
  return RecipeSearchService(ref);
});
