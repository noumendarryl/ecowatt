import 'package:flutter/material.dart';

import 'app_texts.dart';
import 'app_color_schemes.dart';

class AppThemes {
  AppThemes._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: AppColorSchemes.lightColorScheme,
    textTheme: AppTexts.textTheme,
  );

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: AppColorSchemes.darkColorScheme,
      textTheme: AppTexts.textTheme,
  );
}