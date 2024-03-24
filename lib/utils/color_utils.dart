import 'package:flutter/material.dart';

/// Returns a contrasting color based on the luminance of the given color.
Color getContrastColor(Color color) {
  return ThemeData.estimateBrightnessForColor(color) == Brightness.light
      ? Colors.black
      : Colors.white;
}
