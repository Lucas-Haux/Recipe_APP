import 'package:recipe_box/domain/models/recipe_model.dart';

import 'package:flutter/material.dart';
import 'package:recipe_box/ui/home/home_screen.dart';
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

  development.main();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      darkTheme: themeData,
      onGenerateRoute: (settings) {
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            switch (settings.name) {
              case '/':
                return const HomeScreen();
              case '/searchPage':
                return const SearchScreen();
              case '/searchPage/searchResults':
                return const SearchResultsScreen();
              case '/searchPage/searchResults/recipe':
                final args = settings.arguments as int?;
                return RecipeScreen(recipeListIndex: args ?? 0);
              default:
                return const HomeScreen(); // Default fallback
            }
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration:
              const Duration(milliseconds: 800), // Slower Hero animation
        );
      },
    );
  }
}
