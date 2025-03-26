import 'package:recipe_box/domain/models/recipe_model.dart';

import 'package:flutter/material.dart';
import 'package:recipe_box/ui/home/home_screen.dart';
import 'package:recipe_box/ui/home/widgets/favorites/favorites_screen.dart';
import 'package:recipe_box/ui/recipe/recipe_screen.dart';
import 'package:recipe_box/ui/search/search_screen.dart';
import 'package:recipe_box/ui/search_results/search_results_screen.dart';
import 'main_development.dart' as development;
import 'data/repositories/theme_repository.dart';
import 'package:flutter/scheduler.dart';

late ThemeData themeData;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  themeData = await ThemeRepository().getAppTheme();
  print(themeData.cardTheme.shape.toString());

  development.main();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      darkTheme: themeData,
      onGenerateRoute: (homePage) {
        return PageRouteBuilder(
          settings: homePage,
          pageBuilder: (context, animation, secondaryAnimation) {
            switch (homePage.name) {
              case '/':
                return const HomeScreen();
              case '/favorites':
                final List<RecipeModel> favorites =
                    homePage.arguments as List<RecipeModel>;
                return FavoritesScreen(favorites: favorites);
              case '/searchPage':
                return const SearchScreen();
              case '/searchPage/searchResults':
                return const SearchResultsScreen();
              case '/searchPage/searchResults/recipe':
                final Map<String, dynamic> args =
                    homePage.arguments as Map<String, dynamic>;
                return RecipeScreen(
                  recipeListIndex: args['recipeListIndex'],
                  title: args['title'],
                  imageUrl: args['imageUrl'],
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
      },
    );
  }
}
