import 'package:ecowatt/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppColorSchemes{
  AppColorSchemes._();

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    surface: kcBackgroundColor, // Background Color
    primary: kcPrimaryColor,
    onPrimary: Color(0xFFD5D9EB),
    secondary: kcSecondaryColor,
    onSecondary: Color(0xFFB1CA65),
    tertiary: kcMediumGrey,
    onTertiary: kcLightGrey,
    error: Color(0xFFEB8888),
    onError: Color(0xFFFFC5DE),
    onSurface: kcWhite,
    scrim: kcDark, // Texts and Labels Color
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    surface: kcDark, // Background Color
    primary: kcPrimaryColor,
    onPrimary: Color(0xFFD5D9EB),
    secondary: kcSecondaryColor,
    onSecondary: Color(0xFFB1CA65),
    tertiary: kcMediumGrey,
    onTertiary: kcLightGrey,
    error: Color(0xFFEB8888),
    onError: Color(0xFFFFC5DE),
    onSurface: kcLightDark,
    scrim: kcWhite, // Texts and Labels Color
  );
}