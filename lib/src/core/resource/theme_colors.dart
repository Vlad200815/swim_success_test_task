import 'dart:ui';

class ThemeColors {
  ThemeColors._();

  // Primary accent — bright mint green
  static const Color primary = Color(0xFF2EE6A6);
  static const Color primaryDark = Color(0xFF1FB386);

  // Backgrounds — deep navy/black, slightly lighter surfaces for cards
  static const Color background = Color(0xFF0A0E16);
  static const Color surface = Color(0xFF12161F);
  static const Color surfaceVariant = Color(0xFF1A1F2B);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8B93A1);
  static const Color textMuted = Color(0xFF5C6470);

  // Borders / dividers / inactive track (e.g. unfilled progress segments)
  static const Color border = Color(0xFF232A38);
  static const Color divider = Color(0xFF2A3140);
  static const Color inactiveTrack = Color(0xFF222836);
}
