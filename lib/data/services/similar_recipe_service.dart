import 'package:http/http.dart' as http;
import 'dart:convert';

class SimilarRecipeService {
  Future<dynamic> fetchSimilarRecipes(int id) async {
    try {
      const String appKey = '096cc91305b04684ab47dfebc84bc59e';

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
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw 'api response != 200: ${response.reasonPhrase}';
      }
    } catch (e) {
      rethrow;
    }
  }
}
