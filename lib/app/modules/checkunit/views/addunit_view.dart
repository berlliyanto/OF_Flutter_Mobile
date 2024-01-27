import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/gradient_button.dart';
import 'package:of_flutter_mobile/app/components/widgets/dropdown/single_dropdown_less.dart';
import 'package:of_flutter_mobile/app/components/widgets/image/image.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/constant/color.dart';
import 'package:of_flutter_mobile/app/utils/validator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/addunit_controller.dart';

class AddunitView extends GetView<AddunitController> {
  AddunitView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "ADD UNIT", colors: colors),
      extendBodyBehindAppBar: true,
      body: GetBuilder<AddunitController>(
        builder: (builder) => BackgroundLayout(
          showLogo: false,
          child: MainLayout(
            isScrollable: true,
            onRefresh: () {
              refreshController.refreshCompleted();
            },
            refreshController: refreshController,
            children: <Widget>[
              title(title: "Add Forklift"),
              const Gap(10),
              imageCard(
                height: 200,
                width: Get.width,
                onTap: () => builder.openSheetImage(),
                colors: colors,
                margins: const [35, 0, 35, 0],
                fileImage: builder.image,
                url: null,
              ).animate().slideY(duration: 400.ms),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: singleDropdownLess(
                        hint: "Code",
                        data: const [
                          {'id': 1, 'name': 'SOE'},
                          {'id': 2, 'name': 'CKU'},
                        ],
                        width: Get.width * 0.5,
                        colors: colors,
                        onChanged: (value) =>
                            builder.handleOnChange(value, "code"),
                        value: dropdownValue(builder.valueCode.value)),
                  ),
                  const Gap(10),
                  const Heading(
                      heading: "h1", text: "-", textAlign: TextAlign.center),
                  const Gap(10),
                  Expanded(
                    child: TextInput(
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      width: Get.width * 0.5,
                      colors: colors,
                      onChanged: (value) =>
                          builder.handleOnChange(value, "number"),
                      hint: "Number",
                      onTap: () => builder.handleOnFocus(),
                      onTapOutside: (pointer) =>
                          builder.handleOnUnFocus(pointer),
                      errorText: "",
                      isFocus: builder.isFocus.value,
                    ),
                  )
                ],
              ).animate().slideY(),
              const Gap(10),
              singleDropdownLess(
                      hint: "Operation Location",
                      data: const [
                        {'id': 1, 'name': 'FGWH'},
                        {'id': 2, 'name': 'PRODUKSI'},
                        {'id': 3, 'name': 'WIN'},
                      ],
                      width: Get.width,
                      colors: colors,
                      onChanged: (value) =>
                          builder.handleOnChange(value, "location"),
                      value: dropdownValue(builder.valueLocation.value))
                  .animate()
                  .slideY(),
              const Gap(10),
              singleDropdownLess(
                      hint: "PIC",
                      data: const [
                        {'id': 1, 'name': 'YULI'},
                        {'id': 2, 'name': 'ODI'},
                      ],
                      width: Get.width,
                      colors: colors,
                      onChanged: (value) =>
                          builder.handleOnChange(value, "pic"),
                      value: dropdownValue(builder.valuePIC.value))
                  .animate()
                  .slideY(),
              const Gap(10),
              GradientButton(
                      colors: [colors.primaryBlack, colors.primaryBlack],
                      onPressed: () => builder.handleSubmit(),
                      text: "Submit Unit")
                  .animate()
                  .slideY()
            ],
          ),
        ),
      ),
    );
  }
}
