import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> fetchSimilarRecipes(int recipeId) async {
  try {
    const String appKey = '05f5c84cb98f42329f13b049c9f05f5a';

    String queryParameters = 'apiKey=$appKey&'
        'number=5';

    final Uri uri =
        Uri.parse('https://api.spoonacular.com/recipes/$recipeId/similar')
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
    print('used tokens: ${response.headersSplitValues['x-api-quota-request']}');
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
