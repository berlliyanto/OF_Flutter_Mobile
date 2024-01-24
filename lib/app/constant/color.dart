import 'package:flutter/material.dart';

class ColorPicker {
  final ColorPalette colors = ColorPalette(
    black: 0xFF000000,
    cyanDark: 0xFF146C94,
    cyan: 0xFF19A7CE,
    whiteSmoke: 0xFFF6F1F1,
    grey: 0xFF607274,
    primaryText: 0xFF181823,
  );

  get black => Color(colors.black);
  get cyanDark => Color(colors.cyanDark);
  get cyan => Color(colors.cyan);
  get whiteSmoke => Color(colors.whiteSmoke);
  get grey => Color(colors.grey);
  get primaryText => Color(colors.primaryText);
}

class ColorPalette {
  final int black, cyan, cyanDark, whiteSmoke, grey, primaryText;

  ColorPalette(
      {required this.black,
      required this.cyan,
      required this.cyanDark,
      required this.whiteSmoke,
      required this.grey,
      required this.primaryText});
}
