import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTexts{
  AppTexts._();

  static const _fontFamily = 'Axiforma';

  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.lexend(
      fontWeight: FontWeight.w700,
      fontSize: 40.0,
    ),
    headlineLarge: GoogleFonts.lexend(
      fontWeight: FontWeight.w700,
      fontSize: 28.0,
    ),
    titleLarge: GoogleFonts.lexend(
      fontWeight: FontWeight.w700,
      fontSize: 24.0,
    ),
    titleMedium: GoogleFonts.lexend(
      fontWeight: FontWeight.w700,
      fontSize: 20.0,
    ),
    titleSmall: GoogleFonts.lexend(
      fontWeight: FontWeight.w700,
      fontSize: 18.0,
    ),
    bodyLarge: const TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 22.0,
    ),
    bodyMedium: const TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 20.0,
    ),
    bodySmall: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 18.0,
    ),
    labelSmall: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16.0,
    ),
  );
}