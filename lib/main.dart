import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:recipe_box/shared/themes/colors.dart';
import 'dart:io' show Platform;
//import 'package:flutter/scheduler.dart';

import '_main/main_development.dart' as development;
import 'shared/themes/theme.dart';
import '_main/routes.dart';

late ColorScheme colorScheme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initPlatformState();

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

Future<void> initPlatformState() async {
  await Purchases.setLogLevel(LogLevel.verbose);

  late PurchasesConfiguration configuration;
  if (Platform.isAndroid) {
    configuration = PurchasesConfiguration('goog_EJFaOiGOSnQatzecsmQHYDFZlcZ');
    // use your preferred way to determine if this build is for Amazon store
    // checkout our MagicWeather sample for a suggestion
  } else if (Platform.isIOS) {
    configuration = PurchasesConfiguration('');
  }
  await Purchases.configure(configuration);
}
