// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// The accent color used throughout the app.
///
/// It's a shade of purple that evokes a sense of reflection or mirroring, which aligns well with
///  the concept of palindromes (according to Google Gemini at least).
const Color accentColor = Color(0xFF6F42C1);

/// The color used for the result card when the text is not a palindrome.
const Color redResultColor = Color(0xFFF7CAC9);

/// The color used for the result card when the text is a palindrome.
const Color greenResultColor = Color(0xFF9BEECF);

/// The background color of the sponsor badge.
const Color sponsorBackgroundColor = Color(0xFF00A4F9);

/// Returns the app theme for the given brightness.
ThemeData appTheme(Brightness brightness) {
  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: accentColor,
    brightness: brightness,
  );
  return ThemeData.from(
    colorScheme: colorScheme,
  );
}
