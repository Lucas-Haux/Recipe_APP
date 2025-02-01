import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_box/domain/models/recipe_model.dart';

import 'routing/router.dart';

import 'package:flutter/material.dart';
import 'main_development.dart' as development;
import 'data/repositories/theme_repository.dart';

late ThemeData themeData;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  themeData = await ThemeRepository().getAppTheme();
  await Hive.initFlutter();
  Hive.registerAdapter(RecipeModelAdapter());
  Hive.registerAdapter(InstructionModelAdapter());
  Hive.registerAdapter(StepModelAdapter());
  Hive.registerAdapter(SimilarRecipeModelAdapter());
  Hive.registerAdapter(NutritionModelAdapter());

  development.main();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: themeData,
      darkTheme: themeData,
      routerConfig: homeRouter,
    );
  }
}
