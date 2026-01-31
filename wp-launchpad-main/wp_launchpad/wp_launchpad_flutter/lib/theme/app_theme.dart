import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Bold Brand Colors - Startup Quality
  static const Color primaryNavy = Color(0xFF0F2D52);
  static const Color accentOrange = Color(0xFFE85A24);
  static const Color accentOrangeLight = Color(0xFFFF7A45);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color bgLight = Color(0xFFF5F7FA);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textMain = Color(0xFF111827);
  static const Color textMuted = Color(0xFF4B5563);
  static const Color borderGray = Color(0xFFD1D5DB);
  static const Color cardShadow = Color(0x1A000000);

  static ThemeData get light {
    final baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryNavy,
        primary: primaryNavy,
        secondary: accentOrange,
        surface: Colors.white,
        background: bgLight,
      ),
      scaffoldBackgroundColor: bgLight,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.quicksandTextTheme(baseTheme.textTheme).copyWith(
        headlineLarge: GoogleFonts.quicksand(
          textStyle: const TextStyle(
            color: primaryNavy,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        headlineMedium: GoogleFonts.quicksand(
          textStyle: const TextStyle(
            color: primaryNavy,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleLarge: GoogleFonts.quicksand(
          textStyle: const TextStyle(
            color: primaryNavy,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleMedium: GoogleFonts.quicksand(
          textStyle: const TextStyle(
            color: textMain,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        bodyLarge: GoogleFonts.quicksand(
          textStyle: const TextStyle(
            color: textMain,
            fontSize: 16,
            height: 1.5,
          ),
        ),
        bodyMedium: GoogleFonts.quicksand(
          textStyle: const TextStyle(
            color: textMuted,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: primaryNavy,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.quicksand(
          textStyle: const TextStyle(
            color: primaryNavy,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderGray, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryNavy,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryNavy,
          side: const BorderSide(color: borderGray, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // Custom Button Styles for Orange Actions
  static ButtonStyle get orangeButtonStyle => ElevatedButton.styleFrom(
        backgroundColor: accentOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.quicksand(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      );
}
