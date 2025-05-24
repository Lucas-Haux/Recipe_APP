import 'package:dynamic_color/dynamic_color.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:flutter/material.dart';

// Not Used
class AppColors {
  static const ColorScheme _fallbackColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff00629e),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xffcfe5ff),
    onPrimaryContainer: Color(0xff001d34),
    secondary: Color(0xff515e7d),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffd9e2ff),
    onSecondaryContainer: Color(0xff0d1b37),
    tertiary: Color(0xff595a8b),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xffe1dfff),
    onTertiaryContainer: Color(0xff151643),
    surface: Color(0xfffcfcff),
    onSurface: Color(0xff151c24),
    error: Color(0xffba1a1a),
    onError: Color(0xffffffff),
    outline: Color(0xff6f7884),
    shadow: Color(0xff000000),
    inverseSurface: Color(0xff2a3139),
    onInverseSurface: Color(0xffebf1fc),
    inversePrimary: Color(0xff99cbff),
    surfaceTint: Color(0xff00629e),
  );

  static Future<ColorScheme> colorScheme() async {
    CorePalette? materialYouColors = await DynamicColorPlugin.getCorePalette();

    late Brightness brightness;

    switch (ThemeMode.system) {
      case ThemeMode.dark:
        brightness = Brightness.dark;
      case ThemeMode.light:
        brightness = Brightness.light;
      default:
        brightness = Brightness.dark;
    }

    return materialYouColors?.toColorScheme(brightness: Brightness.dark) ??
        _fallbackColorScheme;
  }
}

class PremiumColors {
  static Color darkPurple = const Color.fromARGB(255, 156, 134, 244);
  static Color lightPurple = const Color.fromARGB(255, 226, 134, 244);

  static Color dealDarkGreen = Colors.green.shade400.harmonizeWith(darkPurple);

  static Color dealLightGreen = Colors.green.shade800.harmonizeWith(darkPurple);
}
