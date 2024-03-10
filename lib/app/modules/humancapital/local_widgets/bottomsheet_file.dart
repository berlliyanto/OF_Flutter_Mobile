import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/gradient_button.dart';
import 'package:of_flutter_mobile/app/components/widgets/dropdown/search_dropdown.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

void bottomSheetFileUpload({
  required ColorPicker colors,
  required FutureOr<List<Map<String, dynamic>>> Function(String)
      suggestionsCallback,
  required Function(Map<String, dynamic>?) onSelected,
  required TextEditingController searchDropdownController,
  required TextEditingController textFileController,
  required ScrollController scrollController,
  required VoidCallback? onFileSelected,
  required VoidCallback onSubmit,
  required void Function() onCancel,
}) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Heading(heading: "h2", text: "Select Employee"),
          const Gap(5),
          searchDropdown(
            hint: "Select Employee",
            colors: colors,
            suggestionsCallback: suggestionsCallback,
            onSelected: onSelected,
            textEditingController: searchDropdownController,
            scrollController: scrollController,
          ),
          const Gap(10),
          const Heading(heading: "h2", text: "Attachment"),
          const Gap(5),
          GestureDetector(
            onTap: onFileSelected,
            child: TextInput(
              colors: colors,
              onChanged: (v) {},
              hint: "Select File",
              controller: textFileController,
              isEnabled: false,
              withSuffix: true,
              suffixIcon: Icons.attach_file,
            ),
          ),
          const Gap(5),
          const Paragraph(
            text: "*File PDF maksimal 1 MB",
            fontWeight: FontWeight.bold,
          ),
          const Gap(20),
          GradientButton(
            colors: [colors.green, colors.greenDark],
            onPressed: onSubmit,
            text: "Submit",
          ),
        ],
      ),
    ),
  ).then((value) => onCancel());
}
