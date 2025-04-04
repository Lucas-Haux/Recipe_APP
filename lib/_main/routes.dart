import 'package:flutter/material.dart';
import 'package:recipe_box/features/recipe_display_page/recipe_display_screen.dart';
import 'package:recipe_box/features/recipe_search_page/recipe_search_screen.dart';
import 'package:recipe_box/features/search_results_page/search_results_screen.dart';
import 'package:recipe_box/shared/databases/recipe_favorites/recipe_favorites_database.dart';
import 'package:recipe_box/shared/databases/recipe_search_results/recipe_search_results_database.dart';

import 'package:recipe_box/shared/models/recipe.dart';

// Screens
import 'package:recipe_box/features/home_page/widgets/favorites/favorites_page/favorites_screen.dart';
import 'package:recipe_box/features/home_page/home_screen.dart';

PageRouteBuilder<dynamic> routes(RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) {
      switch (settings.name) {
        case '/':
          return const HomeScreen();

        case '/recipe' || '/favorites/recipe':
          final Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          return RecipeDisplayScreen(
            database: favoritesDatabaseProvider,
            id: arguments['id'],
            recipeTitle: arguments['recipeTitle'],
            recipeImageUrl: arguments['recipeImageUrl'],
          );

        case '/recipe/temp' ||
              '/favorites/recipe/temp' ||
              '/searchPage/searchResults/recipe/temp':
          final Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          return RecipeDisplayScreen(
            key: Key('${arguments['id']}Temp'),
            database: null,
            id: arguments['id'],
            recipeTitle: arguments['recipeTitle'],
            recipeImageUrl: arguments['recipeImageUrl'],
          );

        case '/favorites':
          final List<Recipe> favorites = settings.arguments as List<Recipe>;
          return FavoritesScreen(favorites: favorites);

        case '/searchPage':
          return const RecipeSearchScreen();

        case '/searchPage/searchResults':
          return const SearchResultsScreen();

        case '/searchPage/searchResults/recipe':
          final Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          return RecipeDisplayScreen(
            database: recipeSearchResultsDatabaseProvider,
            id: arguments['id'],
            recipeTitle: arguments['recipeTitle'],
            recipeImageUrl: arguments['recipeImageUrl'],
          );

        default:
          return const HomeScreen();
      }
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );
}
