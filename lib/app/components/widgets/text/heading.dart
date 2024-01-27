import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String heading, text;
  final Color color;
  final TextAlign textAlign;
  final double size;
  final FontWeight fontWeight;
  const Heading(
      {required this.heading,
      required this.text,
      this.color = const Color(0xFF181823),
      this.textAlign = TextAlign.left,
      this.size = 0,
      this.fontWeight = FontWeight.bold,
      super.key});

  double get getFontSize {
    if (size == 0) {
      switch (heading) {
        case "h1":
          return 30;
        case "h2":
          return 20;
        case "h3":
          return 15;
        default:
          return 12;
      }
    } else {
      return size;
    }
  }

  Color get getColor {
    if (color == const Color(0xFF181823)) {
      return const Color(0xFF181823);
    }

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: getColor,
        fontSize: getFontSize,
        fontWeight: fontWeight,
        decoration: TextDecoration.none,
        fontFamily: 'Lato',
      ),
    );
  }
}
