import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:recipe_box/view/pages/search_page.dart';

FocusNode focusNode = FocusNode();

List<String> hrefList = [];
List<String> imageList = [];
List<String> labelList = [];
List<String> timeList = [];
List<String> dishList = [];
List<String> cuisineList = [];
List<String> calorieList = [];

String nextHref = '';

Future<void> fetchRecipes(String query) async {
  const String appId = '';
  const String appKey = '';
  String? cookTime = null;
  String? calorieRange = null;

  calorieRange = '';
  cookTime = '30-60';
  //     'cuisineType': 'Asian',

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

  print(getMealTypeAtIndex(getSelectedMealTypeStrings(selectedMealTypes), 0));
  print(getMealTypeAtIndex(getSelectedMealTypeStrings(selectedMealTypes), 1));
  print(getMealTypeAtIndex(getSelectedMealTypeStrings(selectedMealTypes), 2));
  print(getMealTypeAtIndex(getSelectedMealTypeStrings(selectedMealTypes), 3));
  print(getMealTypeAtIndex(getSelectedMealTypeStrings(selectedMealTypes), 4));

  String queryParameters = 'type=any&'
      'q=${Uri.encodeComponent(query.trim())}&'
      'app_id=$appId&'
      'app_key=$appKey&'
      'imageSize=LARGE&'
      'excluded=vinegar&'
      //'nutrients[CA]=50+&'
      //'nutrients[CHOCDF]=10-30&'
      'field=label&'
      'field=totalTime&'
      'field=calories&'
      'field=cuisineType&'
      'field=dishType&'
      'field=image&';

  Map<String, String?> optionParameters = {
    'time': cookTime,
    'calories': calorieRange,
  };

  optionParameters.forEach((key, value) {
    if (value != null && value.isNotEmpty) {
      print('key: $key value: $value');
      queryParameters += '$key=$value&';
    } else {
      print('nulls:');
      print('key: $key value: $value');
    }
  });

// Construct the URI with the query parameters
  final Uri uri = Uri.parse('https://api.edamam.com/api/recipes/v2').replace(
    query: queryParameters,
  );

  print(uri);

  try {
    final response = await http.get(
      uri,
      headers: {
        'accept': 'application/json',
        'Accept-Language': 'en',
      },
    );
    print(' worked ${response.request}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Handle the response data
      print(response.body);
      List<String> hrefs = [];

      // grab info from response data
      // todo make this a function

      for (var hit in data['hits']) {
        var href = hit['_links']['self']['href'];
        hrefs.add(href);
      }

      nextHref = data['_links']['next']['href'];
      print('nextHref $nextHref');

      List<String> images = [];

      for (var hit in data['hits']) {
        var image = hit['recipe']['image'];
        images.add(image);
      }

      List<String> labels = [];

      for (var hit in data['hits']) {
        var label = hit['recipe']['label'];
        labels.add(label);
      }

      List<String> times = [];

      for (var hit in data['hits']) {
        var time = hit['recipe']['totalTime'];
        times.add(time.toString().substring(0, time.toString().length - 2));
      }

      List<String> calories = [];

      for (var hit in data['hits']) {
        double calorie = hit['recipe']['calories'];
        calories.add(calorie.ceil().toString());
      }

      List<String> cuisines = [];

      for (var hit in data['hits']) {
        var cuisine = hit['recipe']['cuisineType'][0];
        cuisines.add(cuisine);
      }

      List<String> dishs = [];
      int index = 0;

      for (var hit in data['hits']) {
        print(hit['recipe']['dishType'] != null);
        var dish = (hit['recipe']['dishType'] != null)
            ? hit['recipe']['dishType'][0]
            : '';
        dishs.add(dish);
        index++;
        print('index: $index, $dish');
      }

      dishList = dishs;
      cuisineList = cuisines;
      calorieList = calories;
      timeList = times;
      labelList = labels;
      imageList = images;
      hrefList = hrefs;

      print(images);
      int num = 0;

      for (var thing in hrefs) {
        num += 1;
        print(num);
      }

      print(hrefs);
    } else {
      hrefList = [];
      imageList = [];
      // Handle errors
      print('Error: ${response.body}');
    }
  } catch (e) {
    hrefList = [];
    imageList = [];
    print('Failed to fetch recipes: $e');
  }
}
