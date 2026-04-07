import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Official palette from rule.md
  static const Color primaryBlue = Color(0xFF2F6FED);
  static const Color backgroundGray = Color(0xFFF6F8FB);
  static const Color cardWhite = Colors.white;
  static const Color textDark = Color(0xFF162033);
  static const Color textLight = Color(0xFF667085);
  
  static const Color headerDark = Color(0xFF0F1724); // Based on rule "Deep color: #0F1724"
  static const Color sidebarLight = Color(0xFFFFFFFF);
  static const Color tabHighlight = Color(0xFF2F6FED);
  static const Color borderGray = Color(0xFFEAECF0);
  
  // Status colors
  static const Color success = Color(0xFF12B76A);
  static const Color warning = Color(0xFFF79009);
  static const Color risk = Color(0xFFF04438);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: backgroundGray,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        secondary: const Color(0xFF79A7FF),
        background: backgroundGray,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textDark, letterSpacing: -0.05),
        displayMedium: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textDark),
        displaySmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textDark),
        bodyLarge: const TextStyle(fontSize: 16, color: textDark, height: 1.5),
        bodyMedium: const TextStyle(fontSize: 14, color: textDark, height: 1.5),
        bodySmall: const TextStyle(fontSize: 12, color: textLight),
      ),
      cardTheme: CardThemeData(
        color: cardWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // rule.md: 16-24
          side: const BorderSide(color: borderGray, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: borderGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: borderGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        hintStyle: const TextStyle(color: Color(0xFF98A2B3), fontSize: 14),
      ),
      dataTableTheme: DataTableThemeData(
        headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: textDark, fontSize: 13),
        dataTextStyle: const TextStyle(color: textDark, fontSize: 13),
        headingRowColor: WidgetStateProperty.all(const Color(0xFFF9FAFB)),
        dividerThickness: 1,
        horizontalMargin: 24,
      ),
    );
  }
}
