import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/utils/validator.dart';

Widget multiCheckUnit({
  required String key,
  required String title,
  required List<dynamic> itemList,
  required int length,
  required Map<String, dynamic> data,
  required Function(bool? value, Map<String, dynamic> data) onTapOk,
  required Function(bool? value, Map<String, dynamic> data) onTapNotOk,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Paragraph(
            text: "$length. $title",
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          if (title == "Body")
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Paragraph(
                  text: "Baik",
                  fontWeight: FontWeight.w600,
                ),
                Gap(50),
                Paragraph(
                  text: "Tidak",
                  fontWeight: FontWeight.w600,
                ),
                Gap(40),
              ],
            ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: itemList
              .map(
                (item) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Paragraph(
                      text: "- ${item['title'] ?? ''}",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            value: isChecked(data, item['key'] ?? '', true),
                            onChanged: (value) => onTapOk(value, item)),
                        const Gap(45),
                        Checkbox(
                            value: isChecked(data, item['key'] ?? '', false),
                            onChanged: (value) => onTapNotOk(value, item)),
                        const Gap(25),
                      ],
                    )
                  ],
                ),
              )
              .toList(),
        ),
      )
    ],
  );
}
