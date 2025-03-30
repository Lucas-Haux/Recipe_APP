import 'package:flutter/material.dart';
import 'package:recipe_box/shared/themes/colors.dart';
//import 'package:flutter/scheduler.dart';

import '_main/main_development.dart' as development;
import 'shared/themes/theme.dart';
import '_main/routes.dart';

late ColorScheme colorScheme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  colorScheme = await AppColors.colorScheme();

  development.main();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme(colorScheme),
      darkTheme: AppTheme.darkTheme(colorScheme),
      themeMode: ThemeMode.system,
      onGenerateRoute: (settings) => routes(settings),
    );
  }
}
