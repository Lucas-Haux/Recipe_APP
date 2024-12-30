import 'package:go_router/go_router.dart';
import '../ui/home/widgets/home_screen.dart';
import '../ui/search/widgets/search_screen.dart';
import '../ui/search_results/widgets/search_results_screen.dart';
import '../ui/recipe/widgets/recipe_screen.dart';

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
        final args = state.extra as Map<String, dynamic>;

        final recipeListIndex = args['recipeListIndex'] as int;

        return RecipeScreen(
          recipeListIndex: recipeListIndex,
          key: Key(recipeListIndex.toString()),
        );
      },
    ),
  ],
);
