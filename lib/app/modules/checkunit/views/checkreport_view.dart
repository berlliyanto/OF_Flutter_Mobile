import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/button.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/gradient_button.dart';
import 'package:of_flutter_mobile/app/components/widgets/dropdown/search_dropdown.dart';
import 'package:of_flutter_mobile/app/components/widgets/dropdown/single_dropdown_less.dart';
import 'package:of_flutter_mobile/app/components/widgets/image/image.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_bigrectangle.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tile.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_twintile.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/checkreport_controller.dart';

class CheckreportView extends GetView<CheckreportController> {
  CheckreportView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List<Widget> body() {
    if (controller.isLoading.value) {
      return [
        skeletonTile(),
        const Gap(10),
        skeletonTile(),
        const Gap(10),
        skeletonTwinTile(),
        const Gap(10),
        skeletonTwinTile(),
        const Gap(10),
        skeletonTwinTile(),
        const Gap(10),
        skeletonBigRectangle(),
        const Gap(10),
        skeletonTile()
      ];
    }

    return [
      searchDropdown(
        hint: "Select Forklift Unit",
        colors: colors,
        suggestionsCallback: (pattern) async {
          return await controller.suggestions(pattern);
        },
        onSelected: (data) => controller.onTypeAheadSelected(data!),
        textEditingController: controller.searchDropDownController,
      ).animate().slideY(duration: 200.ms),
      const Gap(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Heading(
                heading: "h2", text: "Shift", textAlign: TextAlign.start),
          ),
          Expanded(
            child: singleDropdownLess(
              data: controller.listShift,
              hint: "Shift",
              width: Get.width,
              colors: colors,
              value: controller.data["shift_id"],
              onChanged: (value) => controller.onChangedInput("shift", value),
            ),
          ),
        ],
      ).animate().slideY(duration: 250.ms),
      const Gap(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Heading(
                heading: "h2",
                text: "Pallet Amount",
                textAlign: TextAlign.start),
          ),
          Flexible(
            child: TextInput(
              controller: controller.palletController,
              keyboardType: TextInputType.number,
              width: Get.width,
              colors: colors,
              onChanged: (value) => controller.onChangedInput("pallet", value),
              hint: "Pallet Amount",
            ),
          ),
        ],
      ).animate().slideY(duration: 300.ms),
      const Gap(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Heading(
                heading: "h2", text: "Man Hour", textAlign: TextAlign.start),
          ),
          Expanded(
            child: button(
                colors: colors.whiteSmoke,
                borderColor: colors.primaryBlack,
                textColor: colors.primaryBlack,
                onPressed: () =>
                    controller.onManHourPicked(Get.context!, "start"),
                textSize: 16,
                fontWeight: FontWeight.normal,
                text: controller.shiftLoading.value
                    ? "Loading..."
                    : controller.startTime.value),
          ),
          const Gap(10),
          const Heading(heading: "h2", text: "-", textAlign: TextAlign.center),
          const Gap(10),
          Expanded(
            child: button(
                colors: colors.whiteSmoke,
                borderColor: colors.primaryBlack,
                textColor: colors.primaryBlack,
                onPressed: () =>
                    controller.onManHourPicked(Get.context!, "end"),
                textSize: 16,
                fontWeight: FontWeight.normal,
                text: controller.shiftLoading.value
                    ? "Loading..."
                    : controller.endTime.value),
          ),
        ],
      ).animate().slideY(duration: 350.ms),
      const Gap(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Heading(
                heading: "h2",
                text: "Forklift Hour Meter",
                textAlign: TextAlign.start),
          ),
          Expanded(
            child: TextInput(
              controller: controller.forkliftHMController,
              keyboardType: TextInputType.number,
              width: Get.width,
              colors: colors,
              onChanged: (value) =>
                  controller.onChangedInput("forklift_hour_meter", value),
              hint: "Forklift Hour Meter",
            ),
          ),
        ],
      ).animate().slideY(duration: 400.ms),
      const Divider(),
      ...controller.buildCheckUnitItems,
      const Divider(),
      const Gap(10),
      const Heading(
          heading: "h2",
          text: "Forklift Documentation",
          textAlign: TextAlign.start),
      const Gap(10),
      Container(
        padding: const EdgeInsets.all(10),
        height: 323,
        width: Get.width,
        decoration: BoxDecoration(
            color: colors.whiteSmoke,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10, color: colors.primaryBlack.withOpacity(0.1))
            ]),
        child: GridView(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 1.2,
            mainAxisSpacing: 10,
          ),
          children: [
            imageCard(
                fileImage: controller.imageFront,
                additionalText: "(Sisi Depan)",
                fontSize: 20,
                height: 200,
                width: Get.width,
                onTap: () => controller.openSheetImage("front"),
                colors: colors),
            imageCard(
                fileImage: controller.imageBack,
                additionalText: "(Sisi Belakang)",
                fontSize: 20,
                height: 200,
                width: Get.width,
                onTap: () => controller.openSheetImage("back"),
                colors: colors),
            imageCard(
                fileImage: controller.imageRight,
                additionalText: "(Sisi Kanan)",
                fontSize: 20,
                height: 200,
                width: Get.width,
                onTap: () => controller.openSheetImage("right"),
                colors: colors),
            imageCard(
                fileImage: controller.imageLeft,
                additionalText: "(Sisi Kiri)",
                fontSize: 20,
                height: 200,
                width: Get.width,
                onTap: () => controller.openSheetImage("left"),
                colors: colors),
          ],
        ),
      ),
      const Divider(),
      TextInput(
        controller: controller.unitNotesController,
        maxLines: null,
        label: "Catatan Khusus Unit",
        keyboardType: TextInputType.multiline,
        width: Get.width,
        colors: colors,
        onChanged: (value) =>
            controller.onChangedInput("forklift_notes", value),
        hint: "Input Catatan Khusus Unit",
      ),
      const Gap(10),
      TextInput(
        controller: controller.safetyNotesController,
        maxLines: null,
        label: "Catatan Khusus Safety Features",
        keyboardType: TextInputType.multiline,
        width: Get.width,
        colors: colors,
        onChanged: (value) => controller.onChangedInput("safety_notes", value),
        hint: "Input Catatan Khusus Safety Features",
        onTapOutside: (value) => FocusManager.instance.primaryFocus?.unfocus(),
      ),
      const Gap(10),
      GradientButton(
        colors: [colors.cyan, colors.cyanDark],
        onPressed: () => controller.handleSubmit(),
        text: "Submit",
      ),
      const Gap(10),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "CHECKLIST REPORT", colors: colors),
      extendBodyBehindAppBar: true,
      body: GetBuilder<CheckreportController>(builder: (builder) {
        return BackgroundLayout(
          showBottom: false,
          showLogo: false,
          child: MainLayout(
            isScrollable: true,
            refreshController: refreshController,
            onRefresh: () async {
              await builder.fetchAllAPI();
              refreshController.refreshCompleted();
            },
            children: [
              title(
                title: "Checklist Report",
                icon: FontAwesomeIcons.clockRotateLeft,
                onPressed: () => Get.toNamed(Routes.CHECKHISTORY),
                withLeading: true,
              ).animate().slideY(duration: 150.ms, begin: -0.1, end: 0),
              ...body(),
            ],
          ),
        );
      }),
    );
  }
}
