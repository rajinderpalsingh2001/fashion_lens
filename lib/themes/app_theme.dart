import 'package:flutter/material.dart';

class AppTheme {
  static final MaterialColor _baseColor = Colors.green;
  static Color primaryColor = _baseColor.shade800;
  static Color lightPrimaryColor = _baseColor.shade50;
  static Color milkyWhite = Colors.grey.shade50;
  static Color nagarroDarkBlue = Color.fromRGBO(6,4, 31, 1);
  static const nagarroGreen = Color.fromRGBO(7, 215, 172, 1);
  static Color black = Colors.black;
  static ThemeData themeData = ThemeData(
    primarySwatch: _baseColor,
    colorScheme: ColorScheme.light(
      surface: milkyWhite,
      onSurface: nagarroDarkBlue, // Text on surface (dark text for light theme)
      primary: nagarroGreen, // Dark purple as the primary color
      onPrimary: milkyWhite, // White text on primary color
      secondary: _baseColor.shade200, // Light purple for accents
      onSecondary: milkyWhite, // Text on secondary elements
      tertiary: _baseColor.shade100, // Subtle light purple for highlights
      outline: Colors.grey.shade300, // Outline color
    ),
    scaffoldBackgroundColor: milkyWhite, // Light background for screens
    appBarTheme: AppBarTheme(
      backgroundColor: milkyWhite, // AppBar with dark purple
      foregroundColor: milkyWhite, // White text in AppBar
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: milkyWhite, // White text on button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge:
          TextStyle(color: Colors.black87, fontSize: 16), // Dark text for body
      bodyMedium: TextStyle(
          color: Colors.black54, fontSize: 14), // Lighter text for secondary
      bodySmall: TextStyle(
          color: Colors.black38, fontSize: 12), // Lightest text for hints
    ),
    cardTheme: CardThemeData(
      color: milkyWhite, // Card background
      elevation: 6.0,
      shadowColor: Colors.black, // Subtle shadow for light theme
      margin: const EdgeInsets.all(8.0),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppTheme._baseColor,
    ),
    dividerColor: _baseColor.shade100, // Divider with purple tint
    useMaterial3: true,
  );
}
