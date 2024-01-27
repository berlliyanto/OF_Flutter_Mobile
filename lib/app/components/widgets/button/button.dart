import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';

Widget button({
  required String text,
  required VoidCallback onPressed,
  double width = 1,
  Color colors = Colors.transparent,
  Color borderColor = Colors.transparent,
  Color textColor = Colors.white,
  double textSize = 18,
  FontWeight fontWeight = FontWeight.bold,
}) {
  return Container(
    width: Get.width * width,
    decoration: BoxDecoration(
      color: colors,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: borderColor),
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
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
