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
      yellowDark: 0xFFF3B95F,
      soekimanPallet1: 0xFFF0583D,
      soekimanPallet2: 0xFFF1634A,
      soekimanPallet3: 0xFFF06046,
      soekimanPallet4: 0xFFF3836F,
      soekimanPallet5: 0xFFFBDED9);

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
  Color get soekimanPallet1 => Color(colors.soekimanPallet1);
  Color get soekimanPallet2 => Color(colors.soekimanPallet2);
  Color get soekimanPallet3 => Color(colors.soekimanPallet3);
  Color get soekimanPallet4 => Color(colors.soekimanPallet4);
  Color get soekimanPallet5 => Color(colors.soekimanPallet5);
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
      yellowDark,
      soekimanPallet1,
      soekimanPallet2,
      soekimanPallet3,
      soekimanPallet4,
      soekimanPallet5;

  ColorPalette({
    required this.black,
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
    required this.yellowDark,
    required this.soekimanPallet1,
    required this.soekimanPallet2,
    required this.soekimanPallet3,
    required this.soekimanPallet4,
    required this.soekimanPallet5,
  });
}
