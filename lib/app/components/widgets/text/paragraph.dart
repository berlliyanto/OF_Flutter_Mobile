import 'package:flutter/material.dart';

class Paragraph extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final int? maxLines;
  const Paragraph(
      {required this.text,
      this.fontSize = 14,
      this.color = const Color(0xFF181823),
      this.textAlign = TextAlign.left,
      this.fontWeight = FontWeight.normal,
      this.overflow = TextOverflow.clip,
      this.maxLines,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontFamily: "Lato",
        fontWeight: fontWeight,
      ),
      overflow: overflow,
    );
  }
}
