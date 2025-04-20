import 'package:isar/isar.dart';

part 'recipe.g.dart';

@collection
class Recipe {
  final Id id;

  final String title;
  final String imageUrl;
  final String sourceName;
  final String sourceUrl;
  final List<SimilarRecipe>? similarRecipes;

  final bool popular;
  final bool vegetarian;
  final bool vegan;
  final List<String> cuisines;
  final List<String> dishTypes;
  final List<String> diets;

  final int time;
  final int servings;
  final double pricePerServing;
  final double healthScore;
  final int weightWatcher;
  final int calories;
  final int protein;
  final int fat;

  final String summary;
  final List<String> ingredients;
  final List<NutritionModel>? nutrients;
  final List<Instruction> instructions;
  final String? instructionsParagraph;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.sourceName,
    required this.sourceUrl,
    this.similarRecipes,
    required this.popular,
    required this.vegetarian,
    required this.vegan,
    required this.cuisines,
    required this.dishTypes,
    required this.diets,
    required this.time,
    required this.servings,
    required this.pricePerServing,
    required this.healthScore,
    required this.weightWatcher,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.summary,
    required this.ingredients,
    this.nutrients,
    required this.instructions,
    this.instructionsParagraph,
  });

  factory Recipe.fromJson(Map<String, dynamic> jsonData) {
    return Recipe(
      id: jsonData['id'],

      title: jsonData['title'],
      imageUrl: _convertImage(jsonData['image']),
      sourceName: jsonData['sourceName'],
      sourceUrl: jsonData['sourceUrl'],
      similarRecipes: null, // never provided

      popular: jsonData['veryPopular'],
      vegetarian: jsonData['vegetarian'],
      vegan: jsonData['vegan'],
      cuisines: _checkIfJsonDataPresent(jsonData['cuisines']),
      dishTypes: _checkIfJsonDataPresent(jsonData['dishTypes']),
      diets: _checkIfJsonDataPresent(jsonData['diets']),

      time: jsonData['readyInMinutes'],
      servings: jsonData['servings'],
      // TODO increase this, inflation wasn't accounted for it seems
      pricePerServing: jsonData['pricePerServing'] / 100,
      healthScore: jsonData['healthScore'],
      weightWatcher: jsonData['weightWatcherSmartPoints'],
      calories: _getIntFromParagraph(jsonData['summary'], ' calories'),
      protein: _getIntFromParagraph(jsonData['summary'], 'g of protein'),
      fat: _getIntFromParagraph(jsonData['summary'], 'g of fat'),

      summary: jsonData['summary'],
      ingredients:
          _extractStringFromList(jsonData['extendedIngredients'], 'original'),
      nutrients:
          (_checkIfJsonDataPresent2(jsonData['nutrition']['nutrients']) as List)
              .map((nutrient) => NutritionModel.fromJson(nutrient))
              .toList(),
      instructions: _returnListOfInstructions(jsonData),
      instructionsParagraph: jsonData['instructions'],
    );
  }

  Recipe copyWith({
    int? id,
    String? title,
    String? imageUrl,
    String? sourceName,
    String? sourceUrl,
    List<SimilarRecipe>? similarRecipes,
    bool? popular,
    bool? vegetarian,
    bool? vegan,
    List<String>? cuisines,
    List<String>? dishTypes,
    List<String>? diets,
    int? time,
    int? servings,
    double? pricePerServing,
    double? healthScore,
    int? weightWatcher,
    int? calories,
    int? protein,
    int? fat,
    String? summary,
    List<String>? ingredients,
    List<NutritionModel>? nutrients,
    List<Instruction>? instructions,
    String? instructionsParagraph,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      sourceName: sourceName ?? this.sourceName,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      similarRecipes: similarRecipes ?? this.similarRecipes,
      popular: popular ?? this.popular,
      vegetarian: vegetarian ?? this.vegetarian,
      vegan: vegan ?? this.vegan,
      cuisines: cuisines ?? this.cuisines,
      dishTypes: dishTypes ?? this.dishTypes,
      diets: diets ?? this.diets,
      time: time ?? this.time,
      servings: servings ?? this.servings,
      pricePerServing: pricePerServing ?? this.pricePerServing,
      healthScore: healthScore ?? this.healthScore,
      weightWatcher: weightWatcher ?? this.weightWatcher,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
      summary: summary ?? this.summary,
      ingredients: ingredients ?? this.ingredients,
      nutrients: nutrients ?? this.nutrients,
      instructions: instructions ?? this.instructions,
      instructionsParagraph:
          instructionsParagraph ?? this.instructionsParagraph,
    );
  }
}

@embedded
class SimilarRecipe {
  int? recipeId;
  String? title;
  int? time;
  int? servings;
  String? imageUrl;

  SimilarRecipe({
    this.recipeId,
    this.title,
    this.time,
    this.servings,
    this.imageUrl,
  });

  factory SimilarRecipe.fromJson(Map<String, dynamic> jsonData) {
    return SimilarRecipe(
      recipeId: jsonData['id'],
      title: jsonData['title'],
      time: jsonData['readyInMinutes'],
      servings: jsonData['servings'],
      imageUrl: _constructImageUrl(jsonData['id'], jsonData['imageType']),
    );
  }
}

@embedded
class Instruction {
  String? title;
  List<InstructionStep>? steps;
  Instruction({
    this.title,
    this.steps,
  });
  factory Instruction.fromJson(Map<String, dynamic> jsonData) {
    return Instruction(
        title: jsonData['name'], steps: _returnListOfSteps(jsonData));
  }
}

@embedded
class InstructionStep {
  int? stepNumber;
  String? stepInstruction;
  List<String>? ingredents;
  List<String>? equipment;
  InstructionStep({
    this.ingredents,
    this.equipment,
    this.stepNumber,
    this.stepInstruction,
  });

  factory InstructionStep.fromJson(Map<String, dynamic> jsonData) {
    return InstructionStep(
      stepNumber: jsonData['number'],
      stepInstruction: jsonData['step'],
      // TODO add these
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
      label: _editNutritionLabels(jsonData['name']),
      amount: jsonData['amount'],
      unit: jsonData['unit'],
      percentage: jsonData['percentOfDailyNeeds'],
    );
  }
}

String _editNutritionLabels(String label) {
  if (label.contains('Carbohydrates')) {
    return label.replaceFirst('Carbohydrates', 'Carbs');
  } else {
    return label;
  }
}

String _convertImage(String imageUrl) {
  final pattern = RegExp(r'\d+x\d+');
  return imageUrl.replaceFirst(pattern, '556x370');
}

String _constructImageUrl(int recipeId, String imageType) {
  // TODO image a image model with a imageSize enum so with one class i can easily change the size of the image dependent on the need. String imageUrl will be gone replaced by Image image;

  String imageSize = "556x370";
  return 'https://img.spoonacular.com/recipes/$recipeId-$imageSize.$imageType';
}

// TODO make this a factory for Instruction
List<Instruction> _returnListOfInstructions(Map<String, dynamic> jsonData) {
  List<Instruction> instructions = [];
  for (var hit in jsonData['analyzedInstructions']) {
    Instruction instruction = Instruction.fromJson(hit);
    instructions.add(instruction);
  }
  return instructions;
}

// TODO make this a factory of steps
List<InstructionStep> _returnListOfSteps(Map<String, dynamic> jsonData) {
  List<InstructionStep> steps = [];
  for (var hit in jsonData['steps']) {
    InstructionStep step = InstructionStep.fromJson(hit);
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

int _getIntFromParagraph(String summary, String searchFor) {
  RegExp regex = RegExp(r'(\d+)\s*' + RegExp.escape(searchFor));
  Match? match = regex.firstMatch(summary);

  if (match != null) {
    int foundData = int.parse(match.group(1)!); // Extract number before keyword
    print('foundData: $foundData');
    return foundData;
  } else {
    return -1; // Use -1 instead of 000 for clarity
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
