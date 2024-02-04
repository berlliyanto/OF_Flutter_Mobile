import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/gradient_button.dart';
import 'package:of_flutter_mobile/app/components/widgets/dropdown/single_dropdown_less.dart';
import 'package:of_flutter_mobile/app/components/widgets/image/image.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_bigrectangle.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_rectangle.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tile.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_twintile.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';
import 'package:of_flutter_mobile/app/utils/validator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/addunit_controller.dart';

class AddunitView extends GetView<AddunitController> {
  AddunitView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final arg = Get.arguments;

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
      Hero(
        tag: controller.forkliftModel.image ?? "",
        child: imageCard(
          height: 200,
          width: Get.width,
          onTap: () => controller.openSheetImage(),
          colors: colors,
          margins: const [35, 0, 35, 0],
          fileImage: controller.image,
          url: controller.urlImage,
        ).animate().fadeIn(),
      ),
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
              isEnabled: controller.isEditMode.value,
              controller: controller.numberCodeController,
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
      ...buttonCondition()
    ];
  }

  Row row({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Paragraph(text: title), Paragraph(text: value)],
    );
  }

  List<Widget> historyChecklist() {
    if (arg != null && arg["isDetail"] && arg["id"] != null) {
      if (controller.isLoading.value) {
        return [skeletonBigRectangle()];
      }
      if (controller.forkliftModel.checklists == null ||
          controller.forkliftModel.checklists!.isEmpty) {
        return [
          const Heading(heading: "h2", text: "Latest Checklist"),
          const Gap(10),
          const Center(
            child: Heading(heading: "h2", text: "No Data Available"),
          )
        ];
      }

      return [
        const Heading(heading: "h2", text: "Latest Checklist"),
        const Gap(10),
        SizedBox(
          height: 500,
          width: Get.width,
          child: ListView(
            padding: EdgeInsets.zero,
            children: controller.forkliftModel.checklists!.map((e) {
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: colors.whiteSmoke,
                  border: Border.all(width: 1, color: colors.primaryBlack),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: colors.primaryBlack.withOpacity(0.1))
                  ],
                ),
                child: Column(
                  children: [
                    row(title: "Form Code :", value: e.formCode!),
                    row(title: "Operator :", value: e.operator!.name),
                    row(title: "Man Hour :", value: e.manHour.toString()),
                    row(
                        title: "Checklist Date :",
                        value: formatDate(e.formattedCreatedAt)),
                  ],
                ),
              );
            }).toList(),
          ),
        )
      ];
    }

    return [const SizedBox()];
  }

  List<Widget> buttonCondition() {
    if (arg != null && arg["isDetail"] && arg["id"] != null) {
      return [
        Row(
          children: [
            const Heading(
                heading: "h2",
                text: "Hour Meter : ",
                textAlign: TextAlign.start),
            const Gap(10),
            Flexible(
              child: TextInput(
                isEnabled: false,
                width: Get.width,
                colors: colors,
                onChanged: (v) {},
                hint: controller.forkliftModel.hourMeter ?? "",
              ),
            ),
          ],
        ),
        const Gap(10),
        GradientButton(
                colors: controller.isEditMode.value
                    ? [colors.green, colors.greenDark]
                    : [colors.primaryBlack, colors.primaryBlack],
                onPressed: () => controller.handleUpdate(),
                text: "Update")
            .animate()
            .fadeIn(),
        const Gap(10),
        GradientButton(
                colors: [colors.red, colors.redDark],
                onPressed: () => controller.handleDelete(),
                text: "Delete")
            .animate()
            .fadeIn()
      ];
    }
    return [
      GradientButton(
              colors: [colors.cyan, colors.cyanDark],
              onPressed: () => controller.handleSubmit(),
              text: "Submit")
          .animate()
          .fadeIn()
    ];
  }

  PreferredSizeWidget appBarCondition() {
    if (arg != null && arg["isDetail"] && arg["id"] != null) {
      return appBar(text: "FORKLIFT DETAIL", colors: colors);
    }

    return appBar(text: "ADD FORKLIFT", colors: colors);
  }

  Widget titleCondition() {
    if (arg != null && arg["isDetail"] && arg["id"] != null) {
      return title(
        title: "Forklift Detail",
        icon: controller.isEditMode.value
            ? FontAwesomeIcons.xmark
            : FontAwesomeIcons.pencil,
        iconColor: controller.isEditMode.value ? colors.red : colors.yellowDark,
        onPressed: () => controller.handleEdit(),
        withLeading: true,
      );
    }
    return title(title: "Add Forklift");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCondition(),
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
              titleCondition()
                  .animate()
                  .slideY(duration: 150.ms, begin: -0.1, end: 0),
              const Gap(10),
              ...body(),
              const Gap(10),
              ...historyChecklist()
            ],
          ),
        ),
      ),
    );
  }
}
