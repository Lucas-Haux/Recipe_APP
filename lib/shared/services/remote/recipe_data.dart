import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipeData {
  Future<dynamic> fetchFullRecipe(int recipeId) async {
    try {
      const String appKey = '05f5c84cb98f42329f13b049c9f05f5a';

      const String queryParameters = 'apiKey=$appKey&'
          'includeNutrition=true&'
          'addWinePairing=true&'
          'addTasteData=true';

      final String recipeInfoUrl =
          'https://api.spoonacular.com/recipes/$recipeId/information?';

      final Uri uri = Uri.parse(recipeInfoUrl).replace(
        query: queryParameters,
      );
      //print('fetch full recipe pre uri: $uri');

      // call api
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      //print('----------- fetch full recipe -----------');
      //print('status code: ${response.statusCode}');
      //print('used tokens: ${response.headersSplitValues['x-api-quota-request']}');
      //print('request ${response.request}');
      //print('----------- END -----------');

      // Check if api call was sucessful and return/throw
      if (response.statusCode == 200) {
        final recipeResponseData = jsonDecode(utf8.decode(response.bodyBytes));

        return recipeResponseData;
      } else if (response.statusCode != 200) {
        throw 'fetch full recipe api response != 200: ${response.reasonPhrase}';
      }
    } catch (e) {
      throw '$e';
    }
  }
}
