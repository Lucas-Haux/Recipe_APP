import 'package:go_router/go_router.dart';
import '../ui/home/home_screen.dart';
import '../ui/search/search_screen.dart';
import '../ui/search_results/search_results_screen.dart';
import '../ui/recipe/recipe_screen.dart';

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
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: (const Duration(milliseconds: 500)),
          child: SearchScreen(searchController: TextEditingController()),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Define custom transitions, like fade-in effect
            final anim =
                CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            return FadeTransition(opacity: anim, child: child);
          },
        );
      },
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
        Map<String, dynamic> args = state.extra as Map<String, dynamic>;

        int recipeListIndex = args['recipeListIndex'] as int;

        return RecipeScreen(
          recipeListIndex: recipeListIndex,
          key: Key(args['id']),
        );
      },
    ),
  ],
);
