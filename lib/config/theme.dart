import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette 
  static const Color _primaryColor = Colors.white;
  static const Color _secondaryColor =  Colors.white;// Lighter Yellow (Secondary)
  static const Color _darkTextColor = Color(0xFF212121); // Dark Grey for Text
  static const Color _lightTextColor = Color(0xFF757575); // Light Grey for Text
  static const Color _scaffoldBackgroundColor =Colors.white; // Light Grey background
  static const Color _cardColor = Colors.white; // White for cards
// Green for success
  static const Color _errorColor = Color(0xFFF44336); // Red for errors

  // Text Styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: _darkTextColor,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: _darkTextColor,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: _darkTextColor,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: _darkTextColor,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: _darkTextColor,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: _darkTextColor,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: _darkTextColor,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: _lightTextColor,
  );

  // Theme Definitions
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    primaryColor: _primaryColor,
    scaffoldBackgroundColor: _scaffoldBackgroundColor,
    cardColor: _cardColor,
    colorScheme: ColorScheme.light(
      primary: _primaryColor,
      secondary: _secondaryColor,
      surface: _cardColor,
      error: _errorColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _secondaryColor,
      foregroundColor: _darkTextColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: _darkTextColor,
        fontSize: 20,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
      ),
      iconTheme: const IconThemeData(color: _darkTextColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _secondaryColor,
      selectedItemColor: _darkTextColor,
      unselectedItemColor: _lightTextColor,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: bodySmall.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: bodySmall,
    ),
    cardTheme: CardThemeData(
      color: _cardColor,
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: _darkTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    dividerTheme: const DividerThemeData(
      thickness: 1,
      color: Color.fromRGBO(0, 0, 0, 0.12),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
  );

  // Direct color access (optional)
  static const Color primaryColor = _primaryColor;
  static const Color primaryColorDark = _scaffoldBackgroundColor;
  static const Color scaffoldBackgroundColor = _scaffoldBackgroundColor;
  static const Color inactiveIconColor = _lightTextColor;
}