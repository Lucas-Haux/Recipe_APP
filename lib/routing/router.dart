import 'package:go_router/go_router.dart';
import '../ui/home/widgets/home_screen.dart';
import '../ui/search/widgets/search_screen.dart';
import '../ui/search_results/widgets/search_results_screen.dart';
import '../ui/recipe/widgets/recipe_screen.dart';
import '../domain/models/recipe_model.dart';

import 'package:flutter/material.dart';

final FocusNode focusNode1 = FocusNode();

// GoRouter configuration
final homeRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    // Searchpage route isnt used due to problems with SearchBarFieldWidget
    GoRoute(
      path: '/search',
      name: 'SearchPage',
      builder: (context, state) =>
          SearchScreen(searchController: TextEditingController()),
    ),
    GoRoute(
      path: '/search_results',
      name: 'SearchResults',
      builder: (context, state) => const SearchResultsScreen(),
    ),
    GoRoute(
      path: '/recipe',
      name: 'Recipe',
      builder: (context, state) {
        final recipe =
            state.extra as RecipeModel; // Retrieve the passed recipe object
        return RecipeScreen(recipe: recipe);
      },
    ),
  ],
);
