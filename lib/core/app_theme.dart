// lib/core/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Earthy Dark Palette
  static const Color bgGradientStart = Color(0xFF2A2820);
  static const Color bgGradientEnd = Color(0xFF14130E);

  // Accents & Texts
  static const Color textLight = Color(0xFFEAE8E3);
  static const Color textMuted = Color(0xFFA6A49F);
  static const Color accentGreen = Color(0xFF8BA888);
  static const Color accentOlive = Color(0xFF5A6348);
  static const Color accentOrange = Color(0xFFD98E54);

  // Glassmorphism specs
  static const Color glassBackground = Color(0x1AFFFFFF); // white with 0.1 opacity
  static const Color glassBorder = Color(0x26FFFFFF); // white with 0.15 opacity
  static const Color glassInput = Color(0x14FFFFFF); // white with 0.08 opacity
}

class AppTheme {
  static ThemeData get darkTheme {
    final baseTextTheme = GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentGreen,
        surface: AppColors.bgGradientStart,
        onSurface: AppColors.textLight,
      ),
      textTheme: baseTextTheme.apply(
        bodyColor: AppColors.textLight,
        displayColor: AppColors.textLight,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          color: AppColors.textLight,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentGreen,
          foregroundColor: const Color(0xFF14130E),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.glassBackground,
        selectedColor: AppColors.accentGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.glassBorder),
        ),
        labelStyle: GoogleFonts.poppins(
          fontSize: 12,
          color: AppColors.textLight,
        ),
      ),
    );
  }
}
