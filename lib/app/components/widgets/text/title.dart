import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';

Widget title({required String title, double size = 30}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Gap(120),
      Heading(
        heading: "h1",
        text: title,
        textAlign: TextAlign.start,
        size: size,
      ),
    ],
  );
}
