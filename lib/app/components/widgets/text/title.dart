import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';

Widget title(
    {required String title,
    double size = 30,
    bool withLeading = false,
    VoidCallback? onPressed,
    Color iconColor = const Color(0xFF181823),
    IconData? icon}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Gap(120),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Heading(
              heading: "h1",
              text: title,
              textAlign: TextAlign.start,
              size: size,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (withLeading)
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                size: 24,
                color: iconColor,
              ),
            )
        ],
      )
    ],
  );
}
