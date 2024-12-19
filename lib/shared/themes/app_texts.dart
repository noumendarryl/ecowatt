import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTexts{
  AppTexts._();

  static const _headerFontFamily = 'Degular';

  static TextTheme textTheme = TextTheme(
    displayLarge: const TextStyle(
      fontFamily: _headerFontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 40.0,
    ),
    headlineLarge: const TextStyle(
      fontFamily: _headerFontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 28.0,
    ),
    titleLarge: const TextStyle(
      fontFamily: _headerFontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 24.0,
    ),
    titleMedium: const TextStyle(
      fontFamily: _headerFontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 20.0,
    ),
    titleSmall: const TextStyle(
      fontFamily: _headerFontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 18.0,
    ),
    bodyLarge: GoogleFonts.inter(
      fontWeight: FontWeight.normal,
      fontSize: 18.0,
    ),
    bodyMedium: GoogleFonts.inter(
      fontWeight: FontWeight.normal,
      fontSize: 16.0,
    ),
    bodySmall: GoogleFonts.inter(
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
    ),
    labelSmall: GoogleFonts.inter(
      fontWeight: FontWeight.normal,
      fontSize: 12.0,
    ),
  );
}