import 'package:basic_utils/basic_utils.dart';
import 'package:hive/hive.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 0) // Assign a unique typeId for this model
class RecipeModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final String sourceName;

  @HiveField(4)
  final String sourceUrl;

  @HiveField(5)
  final int time;

  @HiveField(6)
  final int servings;

  @HiveField(7)
  final double pricePerServing;

  @HiveField(8)
  final bool popular;

  @HiveField(9)
  final bool vegetarian;

  @HiveField(10)
  final bool vegan;

  @HiveField(11)
  final List<dynamic> cuisines;

  @HiveField(12)
  final List<dynamic> dishTypes;

  @HiveField(13)
  final List<dynamic> diets;

  @HiveField(14)
  final List<String> ingredients;

  @HiveField(15)
  final List<InstructionModel> instructions;

  @HiveField(16)
  final String calories;

  @HiveField(17)
  final String protein;

  @HiveField(18)
  final String fat;

  @HiveField(19)
  final int healthScore;

  @HiveField(20)
  final int weightWatcher;

  @HiveField(21)
  final String summary;

  @HiveField(22)
  final String? instructionsParagraph;

  @HiveField(23)
  final List<NutritionModel>? nutrients;

  @HiveField(24)
  final List<SimilarRecipeModel>? similarRecipes;

  RecipeModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.sourceName,
    required this.sourceUrl,
    required this.time,
    required this.servings,
    required this.pricePerServing,
    required this.popular,
    required this.vegan,
    required this.vegetarian,
    required this.cuisines,
    required this.dishTypes,
    required this.diets,
    required this.ingredients,
    required this.instructions,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.healthScore,
    required this.weightWatcher,
    required this.summary,
    this.instructionsParagraph,
    this.nutrients,
    this.similarRecipes,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> jsonData) {
    return RecipeModel(
      id: jsonData['id'],
      title: jsonData['title'],
      imageUrl: _convertImage(jsonData['image']),
      sourceName: jsonData['sourceName'],
      sourceUrl: jsonData['sourceUrl'],
      time: jsonData['readyInMinutes'],
      servings: jsonData['servings'],
      pricePerServing: jsonData['pricePerServing'] / 100,
      popular: jsonData['veryPopular'],
      vegan: jsonData['vegan'],
      vegetarian: jsonData['vegetarian'],
      cuisines: _checkIfJsonDataPresent(jsonData['cuisines']),
      dishTypes: _checkIfJsonDataPresent(jsonData['dishTypes']),
      diets: _checkIfJsonDataPresent(jsonData['diets']),
      ingredients:
          _extractStringFromList(jsonData['extendedIngredients'], 'original'),
      instructions: _returnListOfInstructions(jsonData),
      calories: _getStringFromParagraph(jsonData['summary'], ' calories'),
      protein: _getStringFromParagraph(jsonData['summary'], 'g of protein'),
      fat: _getStringFromParagraph(jsonData['summary'], 'g of fat'),
      healthScore: jsonData['healthScore'],
      weightWatcher: jsonData['weightWatcherSmartPoints'],
      summary: jsonData['summary'],
      instructionsParagraph: jsonData['instructions'],
      nutrients:
          (_checkIfJsonDataPresent(jsonData['nutrition']['nutrients']) as List)
              .map((nutrient) => NutritionModel.fromJson(nutrient))
              .toList(),
    );
  }
  RecipeModel copyWith({
    int? id,
    String? title,
    String? imageUrl,
    String? sourceName,
    String? sourceUrl,
    int? time,
    int? servings,
    double? pricePerServing,
    bool? popular,
    bool? vegetarian,
    bool? vegan,
    List<dynamic>? cuisines,
    List<dynamic>? dishTypes,
    List<dynamic>? diets,
    List<String>? ingredients,
    List<InstructionModel>? instructions,
    String? calories,
    String? protein,
    String? fat,
    int? healthScore,
    int? weightWatcher,
    String? summary,
    String? instructionsParagraph,
    List<NutritionModel>? nutrients,
    List<SimilarRecipeModel>? similarRecipes,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      sourceName: sourceName ?? this.sourceName,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      time: time ?? this.time,
      servings: servings ?? this.servings,
      pricePerServing: pricePerServing ?? this.pricePerServing,
      popular: popular ?? this.popular,
      vegetarian: vegetarian ?? this.vegetarian,
      vegan: vegan ?? this.vegan,
      cuisines: cuisines ?? this.cuisines,
      dishTypes: dishTypes ?? this.dishTypes,
      diets: diets ?? this.diets,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
      healthScore: healthScore ?? this.healthScore,
      weightWatcher: weightWatcher ?? this.weightWatcher,
      summary: summary ?? this.summary,
      instructionsParagraph:
          instructionsParagraph ?? this.instructionsParagraph,
      nutrients: nutrients ?? this.nutrients,
      similarRecipes: similarRecipes ?? this.similarRecipes,
    );
  }
}

@HiveType(typeId: 1)
class InstructionModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<StepModel> steps;
  InstructionModel({
    required this.title,
    required this.steps,
  });
  factory InstructionModel.fromJson(Map<String, dynamic> jsonData) {
    return InstructionModel(
        title: jsonData['name'], steps: _returnListOfSteps(jsonData));
  }
}

@HiveType(typeId: 2)
class StepModel {
  @HiveField(0)
  final int stepNumber;
  @HiveField(1)
  final String stepInstruction;
  @HiveField(2)
  final List<String> ingredents;
  @HiveField(3)
  final List<String> equipment;
  @HiveField(4)
  StepModel({
    required this.ingredents,
    required this.equipment,
    required this.stepNumber,
    required this.stepInstruction,
  });

  factory StepModel.fromJson(Map<String, dynamic> jsonData) {
    return StepModel(
      stepNumber: jsonData['number'],
      stepInstruction: jsonData['step'],
      //ingredents: [''],
      //equipment: [''],
      ingredents: _extractStringFromList(jsonData['ingredients'], 'name'),
      equipment: _extractStringFromList(jsonData['equipment'], 'name'),
    );
  }
}

@HiveType(typeId: 3)
class NutritionModel {
  @HiveField(0)
  final String label;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final String unit;
  @HiveField(3)
  final double percentage;
  NutritionModel({
    required this.label,
    required this.amount,
    required this.unit,
    required this.percentage,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> jsonData) {
    return NutritionModel(
      label: jsonData['name'],
      amount: jsonData['amount'],
      unit: jsonData['unit'],
      percentage: jsonData['percentOfDailyNeeds'],
    );
  }
}

@HiveType(typeId: 4)
class SimilarRecipeModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int time;
  @HiveField(3)
  final int servings;
  @HiveField(4)
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
      imageUrl: _constructImageUrl(jsonData['id'], jsonData['imageType']),
    );
  }
}

String _constructImageUrl(int id, String imageType) {
  return 'https://img.spoonacular.com/recipes/$id-312x231.$imageType';
}

List<InstructionModel> _returnListOfInstructions(
    Map<String, dynamic> jsonData) {
  List<InstructionModel> instructions = [];
  for (var hit in jsonData['analyzedInstructions']) {
    InstructionModel instruction = InstructionModel.fromJson(hit);
    instructions.add(instruction);
  }
  return instructions;
}

List<StepModel> _returnListOfSteps(Map<String, dynamic> jsonData) {
  List<StepModel> steps = [];
  for (var hit in jsonData['steps']) {
    StepModel step = StepModel.fromJson(hit);
    steps.add(step);
  }
  return steps;
}

List<dynamic> _checkIfJsonDataPresent(dynamic jsonData) {
  if (jsonData != null && jsonData.length > 0) {
    return List<dynamic>.from(jsonData);
  } else {
    return [''];
  }
}

List<String> _extractStringFromList(dynamic jsonData, String key) {
  if (jsonData != null && jsonData is List) {
    final extractedString = jsonData.map((list) => list[key] as String);
    return extractedString.toList();
  }
  return [];
}

String _getStringFromParagraph(String summary, String searchFor) {
  RegExp regex = RegExp(r'\d+' + RegExp.escape(searchFor));
  Match? match = regex.firstMatch(summary);
  if (match != null) {
    String foundData = match.group(0)!;
    return StringUtils.capitalize(foundData, allWords: true);
  } else {
    return '';
  }
}

String _convertImage(String imageUrl) {
  final pattern = RegExp(r'\d+x\d+');
  return imageUrl.replaceFirst(pattern, '556x370');
}
