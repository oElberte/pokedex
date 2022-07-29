import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    splashColor: Colors.transparent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.light(
      primary: Colors.purple,
      brightness: Brightness.light,
    ),
  );

  static final darkTheme = ThemeData(
    splashColor: Colors.transparent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.dark(
      primary: Colors.purple,
      secondary: Colors.purple,
      brightness: Brightness.dark,
    ),
  );
}
