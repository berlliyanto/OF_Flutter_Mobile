import 'package:flutter/material.dart';

class ColorPicker {
  final ColorPalette colors = ColorPalette(
    black: 0xFF000000,
    cyanDark: 0xFF146C94,
    cyan: 0xFF19A7CE,
    whiteSmoke: 0xFFF5F5F5,
    grey: 0xFF607274,
    primaryBlack: 0xFF181823,
  );

  Color get black => Color(colors.black);
  Color get cyanDark => Color(colors.cyanDark);
  Color get cyan => Color(colors.cyan);
  Color get whiteSmoke => Color(colors.whiteSmoke);
  Color get grey => Color(colors.grey);
  Color get primaryBlack => Color(colors.primaryBlack);
}

class ColorPalette {
  final int black, cyan, cyanDark, whiteSmoke, grey, primaryBlack;

  ColorPalette(
      {required this.black,
      required this.cyan,
      required this.cyanDark,
      required this.whiteSmoke,
      required this.grey,
      required this.primaryBlack});
}
