import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_box/shared/enums/chip_parameters_modes.dart';
import 'package:recipe_box/shared/enums/recipe_parameters.dart';
import 'package:recipe_box/shared/models/search_parameters.dart';

class RecipesSearch {
  RecipesSearch();

  Future<dynamic> fetchRecipes(num offset, num numberOfRecipes,
      SearchParameters searchPramatersRepository) async {
    try {
      const String appKey = '096cc91305b04684ab47dfebc84bc59e';

      final query = searchPramatersRepository.query;
      print('QUERY: $query');
      // For every cuisines in the map that is set to require add the cuisine display name to the string
      String mealTypes = searchPramatersRepository.meals.keys
          .where((key) => searchPramatersRepository.meals[key] == AndOrType.or)
          .map((meals) => meals.displayName)
          .join(',');

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

      String equipment = searchPramatersRepository.equipment.keys
          .where(
              (key) => searchPramatersRepository.equipment[key] == AndOrType.or)
          .map((equipments) => equipments.displayName)
          .join(',');

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
      String includeIngredients = searchPramatersRepository.ingredients.keys
          .where((key) =>
              searchPramatersRepository.ingredients[key] ==
              RequireExclude.require)
          .join(',');

      String excludeIngredients = searchPramatersRepository.ingredients.keys
          .where((key) =>
              searchPramatersRepository.ingredients[key] ==
              RequireExclude.exclude)
          .join(',');

      String intolerances = searchPramatersRepository.intolerances.keys
          .where((key) =>
              searchPramatersRepository.intolerances[key] ==
              RequireExclude.exclude)
          .map((intolerances) => intolerances.displayName)
          .join(',');

      String shorting() {
        switch (searchPramatersRepository.sorting) {
          case SortType.metaScore:
            return 'meta-score';
          case SortType.popularity:
            return 'popularity';
          case SortType.healthiness:
            return 'healthiness';
          case SortType.price:
            return 'price';
          case SortType.time:
            return 'time';
          default:
            return 'meta-score';
        }
      }

      // Combine all the parameters
      String queryParameters = 'apiKey=$appKey&'
          //'${query.isNotEmpty ? 'titleMatch="${Uri.encodeComponent(query.trim())}"&' : ''}'
          'query="${Uri.encodeComponent(query.trim())}"&'
          'titleMatch=${(searchPramatersRepository.matchTitle) ? Uri.encodeComponent(query.trim()) : ''}&'
          'type=$mealTypes&'
          // TODO this doenst acutally require all the cuisines, it requires the recipe to have one of the list. Need to change the UI and Enums to say include instead of required

          'cuisine=$includedcuisines&'
          'excludeCuisine=$excludedCuisines&'
          'diet=$requiredDiets&'
          'intolerances=$intolerances&'
          'equipment=$equipment&'
          'maxReadyTime=${searchPramatersRepository.maxTime.toInt()}&'
          'maxServings=${searchPramatersRepository.servings.end.toInt()}&'
          'minServings=${searchPramatersRepository.servings.start.toInt()}&'
          'maxCalories=${searchPramatersRepository.calories.end.toInt()}&'
          'minCalories=${searchPramatersRepository.calories.start.toInt()}&'
          'maxProtein=${searchPramatersRepository.protein.end.toInt()}&'
          'minProtein=${searchPramatersRepository.protein.start.toInt()}&'
          'maxFat=${searchPramatersRepository.fat.end.toInt()}&'
          'minFat=${searchPramatersRepository.fat.start.toInt()}&'
          'includeIngredients=$includeIngredients&'
          'excludeIngredients=$excludeIngredients&'
          'fillIngredients=true&'
          'addRecipeInformation=true&'
          'addRecipeInstructions=true&'
          'instructionsRequired=true&'
          'addRecipeNutrition=true&'
          'offset=${offset.toInt()}&'
          'number=$numberOfRecipes&'
          'sort=${shorting()}';

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

        // Add used tokens to data
        recipeResponseData['usedTokens'] =
            double.parse(response.headers['x-api-quota-request'] ?? '999');

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
