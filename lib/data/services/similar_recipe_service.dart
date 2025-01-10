import 'package:http/http.dart' as http;
import 'dart:convert';

class SimilarRecipeService {
  Future<dynamic> fetchSimilarRecipes(int id) async {
    try {
      const String appKey = '1f9d617ba13041859ea773423b0e6291';

      String queryParameters = 'apiKey=$appKey&'
          'number=5';

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
