import 'package:flutter/material.dart';

class ColorPicker {
  final ColorPalette colors = ColorPalette(
      black: 0xFF000000,
      cyanDark: 0xFF146C94,
      cyan: 0xFF19A7CE,
      whiteSmoke: 0xFFF5F5F5,
      grey: 0xFF607274,
      redDark: 0xFFD71313,
      red: 0xFFEB4747,
      primaryBlack: 0xFF181823,
      green: 0xFF29ADB2,
      greenDark: 0xFF03C988,
      yellow: 0xFFFF9843,
      yellowDark: 0xFFF3B95F);

  Color get black => Color(colors.black);
  Color get cyanDark => Color(colors.cyanDark);
  Color get cyan => Color(colors.cyan);
  Color get whiteSmoke => Color(colors.whiteSmoke);
  Color get grey => Color(colors.grey);
  Color get primaryBlack => Color(colors.primaryBlack);
  Color get redDark => Color(colors.redDark);
  Color get red => Color(colors.red);
  Color get green => Color(colors.green);
  Color get greenDark => Color(colors.greenDark);
  Color get yellow => Color(colors.yellow);
  Color get yellowDark => Color(colors.yellowDark);
}

class ColorPalette {
  final int black,
      cyan,
      cyanDark,
      whiteSmoke,
      grey,
      primaryBlack,
      redDark,
      red,
      green,
      greenDark,
      yellow,
      yellowDark;

  ColorPalette(
      {required this.black,
      required this.cyan,
      required this.cyanDark,
      required this.whiteSmoke,
      required this.grey,
      required this.primaryBlack,
      required this.redDark,
      required this.red,
      required this.green,
      required this.greenDark,
      required this.yellow,
      required this.yellowDark});
}
