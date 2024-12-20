import 'package:basic_utils/basic_utils.dart';

class RecipeModel {
  final int id;
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
  final List<dynamic> cuisines;
  final List<dynamic> dishTypes;
  final List<dynamic> diets;
  final List<String> ingredients;
  final List<InstructionModel> instructions;
  final String calories;
  final String protein;
  final String fat;
  final int healthScore;
  final int weightWatcher;
  final String summary;

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
  });

  factory RecipeModel.fromJson(Map<String, dynamic> jsonData) {
    return RecipeModel(
      id: jsonData['id'],
      title: jsonData['title'],
      imageUrl: jsonData['image'],
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
    );
  }
}

class InstructionModel {
  final String title;
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

class StepModel {
  final int stepNumber;
  final String stepInstruction;
  final List<String> ingredents;
  final List<String> equipment;
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
