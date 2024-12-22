import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeSearchService {
  Future<dynamic> fetchRecipes(String query) async {
    try {
      const String appKey = '05f5c84cb98f42329f13b049c9f05f5a';

      // TODO grab the parameters from a differnt repository
      String queryParameters = 'query=${Uri.encodeComponent(query.trim())}&'
          'apiKey=$appKey&'
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
