import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color accent = Color(0xFFE65100);
  static const Color textHeading = Colors.white;
  static const Color textBody = Color(0xFFB0B0B0); // Light Grey
}

ThemeData getAppTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.accent,
    colorScheme: ColorScheme.dark(
      primary: AppColors.accent,
      surface: AppColors.surface,
      background: AppColors.background,
      secondary: AppColors.accent,
    ),
    cardColor: AppColors.surface,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        color: AppColors.textHeading,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.montserrat(
        color: AppColors.textHeading,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.montserrat(
        color: AppColors.textHeading,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.montserrat(
        color: AppColors.textHeading,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.montserrat(
        color: AppColors.textHeading,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.montserrat(
        color: AppColors.textHeading,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.montserrat(
        color: AppColors.textHeading,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: AppColors.textBody,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: AppColors.textBody,
      ),
      bodySmall: GoogleFonts.roboto(
        color: AppColors.textBody,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      titleTextStyle: GoogleFonts.montserrat(
        color: AppColors.textHeading,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      hintStyle: GoogleFonts.roboto(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.accent),
      ),
    ),
  );
}
