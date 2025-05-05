import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFFFFC107); // Yellow (Primary)
  static const Color _secondaryColor = Color(0xFFFDD835); // Lighter Yellow (Secondary)
  static const Color _darkTextColor = Color(0xFF212121); // Dark Grey for Text
  static const Color _lightGreyColor = Color(0xFF757575); // light gray for inactive icon

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    primaryColor: _primaryColor,
    colorScheme: ColorScheme.light(
      primary: _primaryColor,
      secondary: _secondaryColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppTheme._primaryColor,
      foregroundColor: AppTheme._darkTextColor,
      titleTextStyle: TextStyle(
          color: AppTheme._darkTextColor,
          fontSize: 20,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _primaryColor,
      selectedItemColor: _darkTextColor,
      unselectedItemColor: _lightGreyColor,
      type: BottomNavigationBarType.fixed,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
  );

  static const Color inactiveIconColor = _lightGreyColor;
}