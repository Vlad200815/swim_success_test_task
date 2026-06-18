import 'package:flutter/material.dart';

import 'theme_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ThemeColors.background,
      primaryColor: ThemeColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: ThemeColors.primary,
        onPrimary: Colors.black,
        secondary: ThemeColors.primary,
        onSecondary: Colors.black,
        surface: ThemeColors.surface,
        onSurface: ThemeColors.textPrimary,
        error: Color(0xFFFF5C5C),
        onError: Colors.white,
      ),

      textTheme: const TextTheme(
        // Big bold headline, e.g. "What's your fastest 100m freestyle?"
        headlineLarge: TextStyle(
          color: ThemeColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w800,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          color: ThemeColors.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: ThemeColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        // Big numbers (e.g. the "3" / "22" pace digits)
        displayLarge: TextStyle(
          color: ThemeColors.textPrimary,
          fontSize: 64,
          fontWeight: FontWeight.w800,
        ),
        bodyLarge: TextStyle(color: ThemeColors.textPrimary, fontSize: 16),
        // Subtext like "This helps us build a more accurate plan for you."
        bodyMedium: TextStyle(
          color: ThemeColors.textSecondary,
          fontSize: 14,
          height: 1.4,
        ),
        // Small caps labels like "YOUR PACE" / "TAP TO EDIT"
        labelLarge: TextStyle(
          color: ThemeColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.4,
        ),
      ),

      iconTheme: const IconThemeData(color: ThemeColors.primary),

      appBarTheme: const AppBarTheme(
        backgroundColor: ThemeColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: ThemeColors.textPrimary),
        titleTextStyle: TextStyle(
          color: ThemeColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColors.primary,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ThemeColors.textPrimary,
          side: const BorderSide(color: ThemeColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      // Segmented progress bar at the top of the reference screen
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ThemeColors.primary,
        linearTrackColor: ThemeColors.inactiveTrack,
      ),

      sliderTheme: SliderThemeData(
        activeTrackColor: ThemeColors.primary,
        inactiveTrackColor: ThemeColors.inactiveTrack,
        thumbColor: ThemeColors.primary,
        overlayColor: ThemeColors.primary.withValues(alpha: 0.1),
      ),

      dividerTheme: const DividerThemeData(
        color: ThemeColors.divider,
        thickness: 1,
      ),

      cardTheme: CardThemeData(
        color: ThemeColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: ThemeColors.border),
        ),
      ),

      // Matches the highlighted "22" picker box with the green border
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ThemeColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: ThemeColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: ThemeColors.primary, width: 1.5),
        ),
        hintStyle: const TextStyle(color: ThemeColors.textMuted),
      ),

      splashColor: ThemeColors.primary.withValues(alpha: 0.1),
      highlightColor: Colors.transparent,
    );
  }
}
