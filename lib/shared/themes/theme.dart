import 'package:dynamic_color/dynamic_color.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

import 'package:flutter/material.dart';
import 'package:recipe_box/shared/themes/colors.dart';

// TODO Needs refactor
class AppTheme {
  static const _textTheme = TextTheme(
    // used on favorites page
    headlineLarge: TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w900,
    ),
    // used on popular search overlay widget
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w900,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w900,
    ),
    titleLarge: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w600,
    ),
    // used at favorites card
    // used on popular searches widget
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFFA4A4A4),
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    labelLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  );

  static ThemeData lightTheme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: colorScheme,
        textTheme: _textTheme,
        //inputDecorationTheme: _inputDecorationTheme,
        //extensions: [
        //  TagChipTheme(
        //    chipColor: AppColors.whiteTransparent,
        //    onChipColor: Colors.white,
        //  ),
        //],
      );

  static ThemeData darkTheme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        brightness: Brightness.dark,
        textTheme: _textTheme,
        //textTheme: _textTheme,
        //inputDecorationTheme: _inputDecorationTheme,
        //extensions: [
        //  TagChipTheme(
        //    chipColor: AppColors.blackTransparent,
        //    onChipColor: Colors.white,
        //  ),
        //],
      );
}

//ThemeData test(ColorScheme colorScheme) {
//  return ThemeData.from(colorScheme: colorScheme, useMaterial3: true);
//}
//
//void printColorScheme(ColorScheme colorScheme) {
//  print('ColorScheme Values:');
//  print('Brightness ${colorScheme.brightness}');
//  print('  Primary: ${colorScheme.primary}');
//  print('  On Primary: ${colorScheme.onPrimary}');
//  print('  Primary Container: ${colorScheme.primaryContainer}');
//  print('  On Primary Container: ${colorScheme.onPrimaryContainer}');
//  print('  Secondary: ${colorScheme.secondary}');
//  print('  On Secondary: ${colorScheme.onSecondary}');
//  print('  Secondary Container: ${colorScheme.secondaryContainer}');
//  print('  On Secondary Container: ${colorScheme.onSecondaryContainer}');
//  print('  Tertiary: ${colorScheme.tertiary}');
//  print('  On Tertiary: ${colorScheme.onTertiary}');
//  print('  Tertiary Container: ${colorScheme.tertiaryContainer}');
//  print('  On Tertiary Container: ${colorScheme.onTertiaryContainer}');
//  print('  Background: ${colorScheme.surface}');
//  print('  On Background: ${colorScheme.onSurface}');
//  print('  Surface: ${colorScheme.surface}');
//  print('  On Surface: ${colorScheme.onSurface}');
//  print('  Surface Variant: ${colorScheme.surfaceContainerHighest}');
//  print('  On Surface Variant: ${colorScheme.onSurfaceVariant}');
//  print('  Error: ${colorScheme.error}');
//  print('  On Error: ${colorScheme.onError}');
//  print('  Outline: ${colorScheme.outline}');
//  print('  Shadow: ${colorScheme.shadow}');
//  print('  Inverse Surface: ${colorScheme.inverseSurface}');
//  print('  On Inverse Surface: ${colorScheme.onInverseSurface}');
//  print('  Inverse Primary: ${colorScheme.inversePrimary}');
//  print('  Surface Tint: ${colorScheme.surfaceTint}');
//}
