import 'package:flutter/material.dart';

ThemeData appTheme(Brightness brightness) {
  final ColorScheme colorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.deepPurple,
    brightness: brightness,
  );
  return ThemeData.from(
    colorScheme: colorScheme,
    textTheme: Typography.material2018().black,
  );
}
