import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';

Row row({required String title, required String value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Paragraph(
        text: title,
        fontSize: 14,
      ),
      Paragraph(
        text: value,
        fontSize: 14,
      )
    ],
  );
}

void previewDialog({
  required Map<String, dynamic> data,
  int unitCount = 0,
  int safetyCount = 0,
  required VoidCallback onOkPress,
  List<String> name = const [],
  required String type,
}) {
  List<Widget> finish() {
    return [
      row(title: "Shift", value: data["shift_id"].toString()),
      row(
        title: "Pallet Amount",
        value: data["pallet_amount"].toString(),
      ),
      row(title: "Productivity Ratio", value: data["ratio"]),
      row(title: "Finish Date", value: formatDate(DateTime.now())),
      const Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: 130,
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Heading(heading: "h3", text: "MAN HOUR"),
                Paragraph(
                  text: data["man_hour"].toString(),
                  fontSize: 18,
                  color: Colors.pink,
                ),
                const Paragraph(text: "HOURS")
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            width: 130,
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Heading(heading: "h3", text: "HOUR METER"),
                Paragraph(
                  text: data["forklift_hour_meter"].toString(),
                  fontSize: 18,
                  color: Colors.blue,
                ),
                const Paragraph(text: "HOURS")
              ],
            ),
          ),
        ],
      ),
      const Gap(10),
    ];
  }

  List<Widget> submit() {
    return [
      row(title: "Unit Code", value: name[0]),
      row(title: "Location", value: name[1]),
      row(title: "Operator", value: name[2]),
      row(
          title: "Hour Meter",
          value: data['main']['forklift_hour_meter'] ?? ""),
      row(title: "Date", value: formatDate(DateTime.now())),
      const Divider(),
      Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Heading(heading: "h3", text: "UNIT CONDITION"),
            const Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Paragraph(text: "A. Unit"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.check,
                          color: Colors.green,
                        ),
                        Paragraph(text: unitCount.toString()),
                        const Gap(20),
                        const Icon(
                          FontAwesomeIcons.xmark,
                          color: Colors.red,
                        ),
                        Paragraph(text: (31 - unitCount).toString()),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Paragraph(text: "A. Safety Feature"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          FontAwesomeIcons.check,
                          color: Colors.green,
                        ),
                        Paragraph(text: safetyCount.toString()),
                        const Gap(20),
                        const Icon(
                          FontAwesomeIcons.xmark,
                          color: Colors.red,
                        ),
                        Paragraph(text: (6 - safetyCount).toString()),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      )
    ];
  }

  AwesomeDialog(
    useRootNavigator: true,
    showCloseIcon: true,
    padding: const EdgeInsets.all(10),
    context: Get.context!,
    dialogType: DialogType.noHeader,
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Heading(heading: "h2", text: "Preview"),
        const Divider(),
        if (type == "submit") ...submit(),
        if (type == "finish") ...finish()
      ],
    ),
    btnOkText: "Submit",
    btnOkOnPress: onOkPress,
  ).show();
}
