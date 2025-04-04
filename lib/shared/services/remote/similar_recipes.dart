import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> fetchSimilarRecipes(int recipeId) async {
  try {
    const String appKey = 'e9099c3488ce479db3778d9f917e9334';

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
