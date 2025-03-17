import 'package:flutter/material.dart';
import 'package:recipe_box/domain/enums.dart';
import 'package:recipe_box/domain/models/search_parameters_model.dart';

Map<String, SearchParameters> popularSearchesData = {
  'Vegan Cupcakes': SearchParameters(
    query: 'Cupcakes',
    diets: {DietType.vegan: AndOrType.and},
    meals: {MealType.dessert: AndOrType.and},
  ),
  'High-Protein Breakfast': SearchParameters(
    query: 'Breakfast',
    protein: RangeValues(15, 100),
    meals: {MealType.breakfast: AndOrType.and},
  ),
  'Quick 30-Minute Dinners': SearchParameters(
    query: 'Dinner',
    meals: {MealType.mainCourse: AndOrType.and},
    maxTime: 30,
  ),
  'Dairy-Free Smoothies': SearchParameters(
    query: 'Smoothie',
    meals: {MealType.beverage: AndOrType.and},
    intolerances: {IntoleranceType.dairy: RequireExclude.exclude},
  ),
  'One-Pot Comfort Food': SearchParameters(
    query: 'One-Pot',
    equipment: {EquipmentType.pot: AndOrType.and},
    meals: {MealType.mainCourse: AndOrType.and, MealType.lunch: AndOrType.and},
  ),
  'Spicy Asian Dishes': SearchParameters(
    query: 'Spicy',
    cuisines: {CuisineType.asian: RequireExclude.require},
  ),
};

Map<String, String> popularSearchesImages = {
  'Vegan Cupcakes':
      'https://tofubud.com/cdn/shop/articles/vegan_ingredients_d42f5779-77db-4d1b-801a-fa263c74610d_1024x.jpg?v=1615297763',
  'High-Protein Breakfast':
      'https://www.lifeextension.com/-/media/lifeextension/wellness/recipes/high-protein-high-fiber-breakfast/high-protein-high-fiber-breakfast-_promo.jpg',
  'Quick 30-Minute Dinners':
      'https://images.saymedia-content.com/.image/c_limit%2Ccs_srgb%2Cq_auto:eco%2Cw_700/MTc0NjE4MTE1NjA1OTk3NTU4/exploring-tequila-and-mezcal.webp',
  'Dairy-Free Smoothies':
      'https://insanelygoodrecipes.com/wp-content/uploads/2022/03/Refreshing-Strawberry-Banana-Smoothie.jpg',
  'One-Pot Comfort Food':
      'https://i2-prod.dailyrecord.co.uk/article33724807.ece/ALTERNATES/s1023/0_sausage-stew-in-bowls.jpg',
  'Spicy Asian Dishes':
      'https://www.thespruceeats.com/thmb/bgIPwN9a07OM16sWXfjUpNca-Lk=/3865x2576/filters:fill(auto,1)/hot-and-spicy-chinese-chicken-900774482-5b10d7c33de4230037abb0ef.jpg',
};
