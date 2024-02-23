import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Heading extends StatelessWidget {
  final String heading, text;
  final Color color;
  final TextAlign textAlign;
  final double size;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final int maxLines;
  const Heading(
      {required this.heading,
      required this.text,
      this.color = const Color(0xFF181823),
      this.textAlign = TextAlign.left,
      this.size = 0,
      this.fontWeight = FontWeight.bold,
      this.overflow = TextOverflow.clip,
      this.maxLines = 1,
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
    return AutoSizeText(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        color: getColor,
        fontSize: getFontSize,
        fontWeight: fontWeight,
        decoration: TextDecoration.none,
        fontFamily: 'Lato',
      ),
      overflow: overflow,
    );
  }
}
