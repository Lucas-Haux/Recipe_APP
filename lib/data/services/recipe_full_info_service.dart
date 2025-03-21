import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeFullInfoService {
  Future<dynamic> fetchFullRecipe(int id) async {
    try {
      const String appKey = '096cc91305b04684ab47dfebc84bc59e';

      const String queryParameters = 'apiKey=$appKey&'
          'includeNutrition=true&'
          'addWinePairing=true&'
          'addTasteData=true';

      final String recipeInfoUrl =
          'https://api.spoonacular.com/recipes/$id/information?';

      final Uri uri = Uri.parse(recipeInfoUrl).replace(
        query: queryParameters,
      );
      print('uri: $uri');

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

      // Check if api call was sucessful and return/throw
      if (response.statusCode == 200) {
        final recipeResponseData = jsonDecode(utf8.decode(response.bodyBytes));

        return recipeResponseData;
      } else if (response.statusCode != 200) {
        throw 'api response != 200: ${response.reasonPhrase}';
      }
    } catch (e) {
      throw '$e';
    }
  }
}
