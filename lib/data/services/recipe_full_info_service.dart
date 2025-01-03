import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeFullInfoService {
  Future<dynamic> fetchFullRecipe(int id) async {
    try {
      const String appKey = '9ecb4e675175477d8edbd94c9dfa20a8';

      const String queryParameters = 'apiKey=$appKey&'
          'number=3';

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
        final recipeResponseData = jsonDecode(response.body);
        return recipeResponseData;
      } else if (response.statusCode != 200) {
        throw 'api response != 200: ${response.reasonPhrase}';
      }
    } catch (e) {
      throw '$e';
    }
  }
}
