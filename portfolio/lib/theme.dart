import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const bg = Color(0xFF0D0F14);
  static const surface = Color(0xFF13161D);
  static const card = Color(0xFF181C26);
  static const border = Color(0xFF252A38);
  static const accent = Color(0xFF5B8CFF);
  static const accent2 = Color(0xFFA78BFA);
  static const textColor = Color(0xFFE8EAF0);
  static const muted = Color(0xFF7A80A0);
  static const tagBg = Color(0xFF1E2436);
  static const tagText = Color(0xFF8EAEFF);
  static const danger = Color(0xFFFF6B6B);
  static const success = Color(0xFF4ADE80);

  static const gradientAccent = LinearGradient(
    colors: [accent, accent2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const gradientAccent2 = LinearGradient(
    colors: [accent2, Color(0xFFEC4899)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class AppTheme {
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          secondary: AppColors.accent2,
          surface: AppColors.surface,
        ),
        textTheme: GoogleFonts.spaceGroteskTextTheme(
          ThemeData.dark().textTheme,
        ).apply(
          bodyColor: AppColors.textColor,
          displayColor: AppColors.textColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.accent),
          ),
          hintStyle: const TextStyle(color: AppColors.border),
          labelStyle: const TextStyle(color: AppColors.muted),
        ),
        dividerColor: AppColors.border,
        useMaterial3: true,
      );
}
