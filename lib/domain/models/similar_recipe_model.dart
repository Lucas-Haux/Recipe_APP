class SimilarRecipeModel {
  final int id;
  final String title;
  final int time;
  final int servings;
  final String imageUrl;

  SimilarRecipeModel({
    required this.id,
    required this.title,
    required this.time,
    required this.servings,
    required this.imageUrl,
  });

  factory SimilarRecipeModel.fromJson(Map<String, dynamic> jsonData) {
    return SimilarRecipeModel(
      id: jsonData['id'],
      title: jsonData['title'],
      time: jsonData['readyInMinutes'],
      servings: jsonData['servings'],
      imageUrl: constructImageUrl(jsonData['id'], jsonData['imageType']),
    );
  }
}

String constructImageUrl(int id, String imageType) {
  return 'https://img.spoonacular.com/recipes/$id-312x231.$imageType';
}
