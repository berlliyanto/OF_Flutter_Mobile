import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final List<Color> colors;
  final Color textColor;
  final double width, textSize;
  const GradientButton(
      {required this.colors,
      required this.onPressed,
      required this.text,
      this.textColor = Colors.white,
      this.width = 1,
      this.textSize = 18,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Heading(
                  heading: "h3",
                  text: text,
                  size: textSize,
                  textAlign: TextAlign.center,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
