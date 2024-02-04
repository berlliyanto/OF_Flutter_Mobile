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
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_rectangle.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tile.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_twintile.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/validator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/addunit_controller.dart';

class AddunitView extends GetView<AddunitController> {
  AddunitView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List<Widget> body() {
    if (controller.isLoading.value) {
      return [
        skeletonRectangle(),
        const Gap(10),
        skeletonTwinTile(),
        const Gap(10),
        skeletonTile(),
        const Gap(10),
        skeletonTile(),
        const Gap(10),
        skeletonTile()
      ];
    }

    return [
      imageCard(
        height: 200,
        width: Get.width,
        onTap: () => controller.openSheetImage(),
        colors: colors,
        margins: const [35, 0, 35, 0],
        fileImage: controller.image,
        url: null,
      ).animate().fadeIn(),
      Center(
        child: controller.clearImageButton,
      ),
      const Gap(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: singleDropdownLess(
                hint: "Code",
                data: controller.codeModel,
                width: Get.width * 0.5,
                colors: colors,
                onChanged: (value) => controller.handleOnChange(value, "code"),
                value: dropdownValue(controller.valueCode.value)),
          ),
          const Gap(10),
          const Heading(heading: "h1", text: "-", textAlign: TextAlign.center),
          const Gap(10),
          Expanded(
            child: TextInput(
              maxLength: 4,
              keyboardType: TextInputType.number,
              width: Get.width * 0.5,
              colors: colors,
              onChanged: (value) => controller.handleOnChange(value, "number"),
              hint: "Number",
              onTapOutside: (pointer) => controller.handleOnUnFocus(pointer),
              errorText: "",
            ),
          )
        ],
      ).animate().fadeIn(),
      const Gap(10),
      singleDropdownLess(
              hint: "Operation Location",
              data: controller.locationModel,
              width: Get.width,
              colors: colors,
              onChanged: (value) =>
                  controller.handleOnChange(value, "location"),
              value: dropdownValue(controller.valueLocation.value))
          .animate()
          .fadeIn(),
      const Gap(10),
      singleDropdownLess(
              hint: "PIC",
              data: controller.picModel,
              width: Get.width,
              colors: colors,
              onChanged: (value) => controller.handleOnChange(value, "pic"),
              value: dropdownValue(controller.valuePIC.value))
          .animate()
          .fadeIn(),
      const Gap(10),
      GradientButton(
              colors: [colors.cyan, colors.cyanDark],
              onPressed: () => controller.handleSubmit(),
              text: "Submit")
          .animate()
          .fadeIn()
    ];
  }

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
            onRefresh: () async {
              await builder.fetchAllData();
              refreshController.refreshCompleted();
            },
            refreshController: refreshController,
            children: <Widget>[
              title(title: "Add Forklift")
                  .animate()
                  .slideY(duration: 150.ms, begin: -0.1, end: 0),
              const Gap(10),
              ...body()
            ],
          ),
        ),
      ),
    );
  }
}
