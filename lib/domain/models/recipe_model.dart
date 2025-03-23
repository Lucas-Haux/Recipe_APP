import 'package:basic_utils/basic_utils.dart';

import 'package:isar/isar.dart';

part 'recipe_model.g.dart';

@collection
class RecipeModel {
  Id? id = Isar.autoIncrement;
  final int recipeId;

  final String title;

  final String imageUrl;

  final String sourceName;

  final String sourceUrl;

  final int time;

  final int servings;

  final double pricePerServing;

  final bool popular;

  final bool vegetarian;

  final bool vegan;

  final List<String> cuisines;

  final List<String> dishTypes;

  final List<String> diets;

  final List<String> ingredients;

  final List<InstructionModel> instructions;

  final String calories;

  final String protein;

  final String fat;

  final double healthScore;

  final int weightWatcher;

  final String summary;

  final String? instructionsParagraph;

  final List<NutritionModel>? nutrients;

  final List<SimilarRecipeModel>? similarRecipes;

  RecipeModel({
    required this.recipeId,
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
    this.similarRecipes = null,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> jsonData) {
    return RecipeModel(
      recipeId: jsonData['id'],
      title: jsonData['title'],
      imageUrl: _convertImage(jsonData['image']),
      sourceName: jsonData['sourceName'],
      sourceUrl: jsonData['sourceUrl'],
      time: jsonData['readyInMinutes'],
      servings: jsonData['servings'],
      // TODO divide by 100
      pricePerServing: jsonData['pricePerServing'],
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
          (_checkIfJsonDataPresent2(jsonData['nutrition']['nutrients']) as List)
              .map((nutrient) => NutritionModel.fromJson(nutrient))
              .toList(),
    );
  }
  RecipeModel copyWith({
    int? recipeId,
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
    List<String>? cuisines,
    List<String>? dishTypes,
    List<String>? diets,
    List<String>? ingredients,
    List<InstructionModel>? instructions,
    String? calories,
    String? protein,
    String? fat,
    double? healthScore,
    int? weightWatcher,
    String? summary,
    String? instructionsParagraph,
    List<NutritionModel>? nutrients,
    List<SimilarRecipeModel>? similarRecipes,
  }) {
    return RecipeModel(
      recipeId: recipeId ?? this.recipeId,
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

@embedded
class InstructionModel {
  String? title;
  List<StepModel>? steps;
  InstructionModel({
    this.title,
    this.steps,
  });
  factory InstructionModel.fromJson(Map<String, dynamic> jsonData) {
    return InstructionModel(
        title: jsonData['name'], steps: _returnListOfSteps(jsonData));
  }
}

@embedded
class StepModel {
  int? stepNumber;
  String? stepInstruction;
  List<String>? ingredents;
  List<String>? equipment;
  StepModel({
    this.ingredents,
    this.equipment,
    this.stepNumber,
    this.stepInstruction,
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

@embedded
class NutritionModel {
  String? label;
  double? amount;
  String? unit;
  double? percentage;
  NutritionModel({
    this.label,
    this.amount,
    this.unit,
    this.percentage,
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

@embedded
class SimilarRecipeModel {
  int? recipeId;
  String? title;
  int? time;
  int? servings;
  String? imageUrl;

  SimilarRecipeModel({
    this.recipeId,
    this.title,
    this.time,
    this.servings,
    this.imageUrl,
  });

  factory SimilarRecipeModel.fromJson(Map<String, dynamic> jsonData) {
    return SimilarRecipeModel(
      recipeId: jsonData['id'],
      title: jsonData['title'],
      time: jsonData['readyInMinutes'],
      servings: jsonData['servings'],
      imageUrl: _constructImageUrl(jsonData['id'], jsonData['imageType']),
    );
  }
}

String _constructImageUrl(int recipeId, String imageType) {
  return 'https://img.spoonacular.com/recipes/$recipeId-312x231.$imageType';
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

List<String> _checkIfJsonDataPresent(dynamic jsonData) {
  if (jsonData != null && jsonData.length > 0) {
    print('running check');
    List<String> templist = [];
    for (var item in jsonData) {
      String test = item.toString();
      templist.add(test);
    }
    return templist;
  } else {
    return [''];
  }
}

List<dynamic> _checkIfJsonDataPresent2(dynamic jsonData) {
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
