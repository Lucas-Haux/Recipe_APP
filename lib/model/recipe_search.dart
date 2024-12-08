import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:recipe_box/view/pages/search_page.dart';

FocusNode focusNode = FocusNode();
Completer<void> recipeSearchNotifi = Completer<void>();

List<String> imageList = [];
List<String> labelList = [];
List<String> recipeIdList = [];
List<String> timeList = [];
List<String> dishList = [];
List<String> cuisineList = [];
List<String> calorieList = [];
List<String> proteinList = [];
List<String> fatList = [];
List<String> healthList = [];
List<bool> popularList = [];
List<int> servingsList = [];
List<List<String>> ingredientsList = [];
List<List<String>> equipmentList = [];
List<List<String>> dietList = [];
List<String> sourceNameList = [];
List<String> sourceUrlList = [];
List<List<Map<String, List<RecipeStep>>>> recipeStepsList = [];

dynamic recipeResponseData = '';

Future<void> fetchRecipes(String query) async {
  recipeSearchNotifi = Completer<void>();

  const String appKey = '1f9d617ba13041859ea773423b0e6291';
  // 1f9d617ba13041859ea773423b0e6291
  String? cookTime;
  String? calorieRange;

  String? getMealTypeName(MealType? mealType) {
    switch (mealType) {
      case MealType.dinner:
        return 'Dinner';
      case MealType.lunch:
        return 'Lunch';
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.snack:
        return 'Snack';
      default:
        return '';
    }
  }

  List<String?> getSelectedMealTypeStrings(List<MealType?> selectedMealTypes) {
    return selectedMealTypes
        .map((mealType) => getMealTypeName(mealType) ?? '')
        .toList();
  }

  String? getMealTypeAtIndex(List<String?> mealTypeStrings, int index) {
    if (index < 0 || index >= mealTypeStrings.length) {
      return null; // Return null if the index is out of bounds
    }
    return mealTypeStrings[index];
  }

  String queryParameters = 'query=${Uri.encodeComponent(query.trim())}&'
      'apiKey=$appKey&'
      'fillIngredients=true&'
      'addRecipeInformation=true&'
      'instructionsRequired=true&'
      'sort=meta-score';

  Map<String, String?> optionParameters = {
    'time': cookTime,
    'calories': calorieRange,
  };

//  optionParameters.forEach((key, value) {
//    if (value != null && value.isNotEmpty) {
//      print('key: $key value: $value');
//      queryParameters += '$key=$value&';
//    } else {
//      print('nulls:');
//     print('key: $key value: $value');
//    }
//  });

// Construct the URI with the query parameters
  final Uri uri =
      Uri.parse('https://api.spoonacular.com/recipes/complexSearch').replace(
    query: queryParameters,
  );

  print(uri);

  try {
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    print(' worked ${response.request}');

    if (response.statusCode == 200) {
      recipeResponseData = jsonDecode(response.body);
      // Handle the response recipeResponseData
      print(response.body);
      getRecipeInfo(recipeResponseData);
      recipeSearchNotifi.complete();
    } else {
      imageList = [];
      // Handle errors
      print('Error: ${response.body}');
    }
  } catch (e) {
    imageList = [];
    print('Failed to fetch recipes: $e');
  }
}

Future<void> getRecipeInfo(dynamic recipeResponseData) async {
  recipeStepsList = [];
  recipeStepsList = [];
  sourceNameList = [];
  sourceUrlList = [];
  servingsList = [];
  imageList = [];
  proteinList = [];
  fatList = [];
  calorieList = [];
  dietList = [];
  labelList = [];
  healthList = [];
  popularList = [];
  timeList = [];
  recipeIdList = [];
  ingredientsList = [];
  equipmentList = [];

  for (var hit in recipeResponseData['results']) {
    sourceNameList.add(hit['sourceName']);
    sourceUrlList.add(hit['sourceUrl']);
    servingsList.add(hit['servings']);
    popularList.add(hit['veryPopular']);
    imageList.add(hit['image']);
    labelList.add(StringUtils.capitalize(hit['title'], allWords: true));
    healthList.add(hit['healthScore'].toString());
    timeList.add(hit['readyInMinutes'].toString());
    recipeIdList.add(hit['id'].toString());

    //
    List<String> ingredients = [];
    for (var ingredient in hit['missedIngredients']) {
      ingredients
          .add(StringUtils.capitalize(ingredient['original'], allWords: true));
    }
    ingredientsList.add(ingredients);

    List<String> diets = [];
    for (var diet in hit['diets']) {
      diets.add(StringUtils.capitalize(diet, allWords: true));
    }
    dietList.add(diets);

    String summary = hit['summary'];
    // calories in summary
    addDataFromParagraphToList(summary, calorieList, ' calories');
    // protien in summary
    addDataFromParagraphToList(summary, proteinList, 'g of protein');
    // fat in summary
    addDataFromParagraphToList(summary, fatList, 'g of fat');

    // get all data from analyzed instructions
    List<String> equipmentItems = [];
    List<Map<String, List<RecipeStep>>> listOfSteps = [];
    for (var instruction in hit['analyzedInstructions']) {
      List<RecipeStep> recipeSteps = [];

      for (var step in instruction['steps']) {
        List<String> equipments = [];
        List<String> ingredients = [];
        RecipeStep currentStep = RecipeStep(
          number: '',
          description: '',
          equipment: [],
          ingredients: [],
        );

        for (var ingredient in step['ingredients']) {
          ingredients.add(ingredient['name']);
        }
        for (var equipment in step['equipment']) {
          equipments.add(equipment['name']);
          // add to equipmentList if Equipment isnt allready there
          if (!equipmentItems.contains(equipment['name'])) {
            equipmentItems.add(equipment['name']);
          }
        }

        currentStep = RecipeStep(
          number: step['number'].toString(),
          description: step['step'],
          equipment: equipments,
          ingredients: ingredients,
        );
        recipeSteps.add(currentStep);
      }
      listOfSteps.add({instruction['name']: recipeSteps});
    }
    equipmentList.add(equipmentItems);
    recipeStepsList.add(listOfSteps);
  }
}

class RecipeStep {
  String number;
  String description;
  List<String> equipment;
  List<String> ingredients;

  RecipeStep({
    required this.number,
    required this.description,
    required this.equipment,
    required this.ingredients,
  });
}

Future<void> addDataFromParagraphToList(
    String summary, List<String> list, String searchFor) async {
  RegExp regex = RegExp(r'\d+' + RegExp.escape(searchFor));
  Match? match = regex.firstMatch(summary);
  if (match != null) {
    String foundData = match.group(0)!;
    list.add(StringUtils.capitalize(foundData, allWords: true));
  } else {
    list.add('');
  }
}
