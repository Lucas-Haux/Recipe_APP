import 'package:dynamic_color/dynamic_color.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

import 'package:flutter/material.dart';

class ThemeRepository {
  Future<ThemeData> getAppTheme() async {
    CorePalette? materialYouColors = await DynamicColorPlugin.getCorePalette();

    late final ColorScheme colorScheme;

    if (materialYouColors != null) {
      printColorScheme(materialYouColors.toColorScheme());
      colorScheme =
          materialYouColors.toColorScheme(brightness: Brightness.dark);
      print('-----------');
      print('materialYouColors');
      print('-----------');
    } else {
      printColorScheme(createCustomColorScheme());
      colorScheme = createCustomColorScheme();
      print('-----------');
      print('customColors');
      print('-----------');
    }
    return ThemeData.from(colorScheme: colorScheme, useMaterial3: true);
  }
}

ThemeData test(ColorScheme colorScheme) {
  return ThemeData.from(colorScheme: colorScheme, useMaterial3: true);
}

void printColorScheme(ColorScheme colorScheme) {
  print('ColorScheme Values:');
  print('Brightness ${colorScheme.brightness}');
  print('  Primary: ${colorScheme.primary}');
  print('  On Primary: ${colorScheme.onPrimary}');
  print('  Primary Container: ${colorScheme.primaryContainer}');
  print('  On Primary Container: ${colorScheme.onPrimaryContainer}');
  print('  Secondary: ${colorScheme.secondary}');
  print('  On Secondary: ${colorScheme.onSecondary}');
  print('  Secondary Container: ${colorScheme.secondaryContainer}');
  print('  On Secondary Container: ${colorScheme.onSecondaryContainer}');
  print('  Tertiary: ${colorScheme.tertiary}');
  print('  On Tertiary: ${colorScheme.onTertiary}');
  print('  Tertiary Container: ${colorScheme.tertiaryContainer}');
  print('  On Tertiary Container: ${colorScheme.onTertiaryContainer}');
  print('  Background: ${colorScheme.surface}');
  print('  On Background: ${colorScheme.onSurface}');
  print('  Surface: ${colorScheme.surface}');
  print('  On Surface: ${colorScheme.onSurface}');
  print('  Surface Variant: ${colorScheme.surfaceContainerHighest}');
  print('  On Surface Variant: ${colorScheme.onSurfaceVariant}');
  print('  Error: ${colorScheme.error}');
  print('  On Error: ${colorScheme.onError}');
  print('  Outline: ${colorScheme.outline}');
  print('  Shadow: ${colorScheme.shadow}');
  print('  Inverse Surface: ${colorScheme.inverseSurface}');
  print('  On Inverse Surface: ${colorScheme.onInverseSurface}');
  print('  Inverse Primary: ${colorScheme.inversePrimary}');
  print('  Surface Tint: ${colorScheme.surfaceTint}');
}

ColorScheme createCustomColorScheme() {
  return const ColorScheme(
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
    surfaceContainerHighest: Color(0xffdae3f1),
    onSurfaceVariant: Color(0xff3f4852),
    error: Color(0xffba1a1a),
    onError: Color(0xffffffff),
    outline: Color(0xff6f7884),
    shadow: Color(0xff000000),
    inverseSurface: Color(0xff2a3139),
    onInverseSurface: Color(0xffebf1fc),
    inversePrimary: Color(0xff99cbff),
    surfaceTint: Color(0xff00629e),
  );
}
