import 'package:http/http.dart' as http;
import 'dart:convert';

class SimilarRecipeService {
  Future<dynamic> fetchSimilarRecipes(int id) async {
    try {
      const String appKey = '05f5c84cb98f42329f13b049c9f05f5a';

      String queryParameters = 'apiKey=$appKey&'
          'number=3';

      final Uri uri =
          Uri.parse('https://api.spoonacular.com/recipes/$id/similar').replace(
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
      throw e;
    }
  }
}
