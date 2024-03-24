import 'package:flutter/material.dart';

// A nice unique shade of purple that should evoke a sense of reflection or mirroring and symbolize
// palindromes
const Color _accentColor = Color(0xFF6A1B9A);

ThemeData appTheme(Brightness brightness) {
  // A color that is white in the light theme and black in the dark theme
  final Color lightWhiteDarkBlack = brightness == Brightness.light ? Colors.white : Colors.black;

  // A color that is black in the light theme and white in the dark theme
  final Color lightBlackDarkWhite = brightness == Brightness.light ? Colors.black : Colors.white;

  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: _accentColor,
    brightness: brightness,
    secondary: _accentColor,
  );
  return ThemeData.from(
    colorScheme: colorScheme,
    textTheme: Typography.material2018().black,
  ).copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: _accentColor,
      foregroundColor: Colors.white,
    ),
  );
}
