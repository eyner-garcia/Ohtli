import 'package:flutter/material.dart';

class AppTheme {
  // --- TEMA CLARO ---
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF9FAFB),

      colorScheme: const ColorScheme.light(
        primary: Color(0xFF1E293B),
        surface: Colors.white,
        onSurface: Color(0xFF0F172A),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF0F172A)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF1E293B),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // --- TEMA OSCURO ---
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF38BDF8),
        surface: Color(0xFF1E293B),
        onSurface: Color(0xFFF8FAFC),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFF8FAFC)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF38BDF8),
          foregroundColor: const Color(0xFF0F172A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}