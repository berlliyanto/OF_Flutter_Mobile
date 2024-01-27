import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';

Widget singleCheckUnit({
  required String key,
  required String title,
  required int length,
  required Function(bool? value) onTapOk,
  required Function(bool? value) onTapNotOk,
  required bool valueOK,
  valueNotOk,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Paragraph(
        text: "$length. $title",
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(value: valueOK, onChanged: onTapOk),
          const Gap(45),
          Checkbox(value: valueNotOk, onChanged: onTapNotOk),
          const Gap(65),
        ],
      ),
    ],
  );
}
