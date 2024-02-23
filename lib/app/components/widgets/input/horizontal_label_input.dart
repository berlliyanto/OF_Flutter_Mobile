import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';

Widget horizontalLabelInput(
    {required String label,
    required Widget child,
    int animationDuration = 300}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Heading(heading: "h2", text: label, textAlign: TextAlign.start),
      ),
      Expanded(child: child),
    ],
  ).animate().slideY(duration: animationDuration.ms);
}
