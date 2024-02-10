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
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';
import 'package:of_flutter_mobile/app/utils/validator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/checkreport_controller.dart';

class CheckreportView extends GetView<CheckreportController> {
  CheckreportView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final arg = Get.arguments;
  final GlobalState globalState = Get.find<GlobalState>();

  List<Widget> topWidget() {
    if (arg != null) {
      return [
        const Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: colors.cyan,
              radius: 8,
            ),
            const Gap(5),
            Heading(
              heading: "h2",
              text: "Unit Code : ${controller.main['unit_code'] ?? ''}",
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: colors.cyanDark,
              radius: 8,
            ),
            const Gap(5),
            Heading(
              heading: "h2",
              text:
                  "Operator : ${controller.main.containsKey("operators") ? controller.main['operators']['name'] ?? '' : ''}",
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: colors.green,
              radius: 8,
            ),
            const Gap(5),
            Heading(
              heading: "h2",
              text:
                  "Location : ${controller.main.containsKey("forklifts") ? controller.main['forklifts']['location']['name'] ?? '' : ''}",
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: colors.greenDark,
              radius: 8,
            ),
            const Gap(5),
            const Heading(
              heading: "h2",
              text: "Checklist Date :",
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Heading(
            heading: "h3",
            text: formatDate(controller.main['created_at']),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: colors.yellow,
              radius: 8,
            ),
            const Gap(5),
            const Heading(
              heading: "h2",
              text: "Supervisor Verification :",
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Heading(
            heading: "h3",
            text: formatDate(controller.main['verification_supervisor']),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: colors.yellowDark,
              radius: 8,
            ),
            const Gap(5),
            const Heading(
              heading: "h2",
              text: "User Verification :",
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Heading(
            heading: "h3",
            text: formatDate(controller.main['verification_user']),
          ),
        ),
        const Divider(),
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
    ];
  }

  Widget buttonCondition() {
    if (arg == null) {
      if (globalState.getPermissions.contains("create-checklist")) {
        return GradientButton(
          colors: [colors.cyan, colors.cyanDark],
          onPressed: () => controller.handleSubmit(),
          text: "Submit",
        );
      }
    }
    if (globalState.getPermissions.contains("verify-checklist")) {
      return GradientButton(
        colors: [colors.green, colors.greenDark],
        onPressed: () => controller.handleVerify(),
        text: "Verify",
      );
    }

    return const SizedBox();
  }

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
      ...topWidget(),
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
              value: dropdownValue(controller.valueShift.value),
              onChanged: (value) => arg != null
                  ? null
                  : controller.onChangedInput("shift", value),
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
              isEnabled: arg == null,
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
                onPressed: () => arg != null
                    ? null
                    : controller.onManHourPicked(Get.context!, "start"),
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
                onPressed: () => arg != null
                    ? null
                    : controller.onManHourPicked(Get.context!, "end"),
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
              isEnabled: arg == null,
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
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Heading(
              heading: "h2",
              text: "Forklift Documentation",
              textAlign: TextAlign.start),
          controller.clearImageButton
        ],
      ),
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
            Hero(
              tag: arg != null ? controller.docs['image_front'] : "front",
              child: imageCard(
                  fileImage: controller.imageFront,
                  url: controller.createUrlImage("front"),
                  additionalText: "(Sisi Depan)",
                  fontSize: 20,
                  height: 200,
                  width: Get.width,
                  onTap: () => arg != null
                      ? Get.toNamed(Routes.ZOOMIMAGE, arguments: {
                          'type': 'checklist',
                          'image': controller.docs['image_front']
                        })
                      : controller.openSheetImage("front"),
                  colors: colors),
            ),
            Hero(
              tag: arg != null ? controller.docs['image_back'] : "back",
              child: imageCard(
                  fileImage: controller.imageBack,
                  url: controller.createUrlImage("back"),
                  additionalText: "(Sisi Belakang)",
                  fontSize: 20,
                  height: 200,
                  width: Get.width,
                  onTap: () => arg != null
                      ? Get.toNamed(Routes.ZOOMIMAGE, arguments: {
                          'type': 'checklist',
                          'image': controller.docs['image_back']
                        })
                      : controller.openSheetImage("back"),
                  colors: colors),
            ),
            Hero(
              tag: arg != null ? controller.docs['image_right'] : "right",
              child: imageCard(
                  fileImage: controller.imageRight,
                  url: controller.createUrlImage("right"),
                  additionalText: "(Sisi Kanan)",
                  fontSize: 20,
                  height: 200,
                  width: Get.width,
                  onTap: () => arg != null
                      ? Get.toNamed(Routes.ZOOMIMAGE, arguments: {
                          'type': 'checklist',
                          'image': controller.docs['image_right']
                        })
                      : controller.openSheetImage("right"),
                  colors: colors),
            ),
            Hero(
              tag: arg != null ? controller.docs['image_left'] : "left",
              child: imageCard(
                  fileImage: controller.imageLeft,
                  url: controller.createUrlImage("left"),
                  additionalText: "(Sisi Kiri)",
                  fontSize: 20,
                  height: 200,
                  width: Get.width,
                  onTap: () => arg != null
                      ? Get.toNamed(Routes.ZOOMIMAGE, arguments: {
                          'type': 'checklist',
                          'image': controller.docs['image_left']
                        })
                      : controller.openSheetImage("left"),
                  colors: colors),
            ),
          ],
        ),
      ),
      const Divider(),
      TextInput(
        isEnabled: arg == null,
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
        isEnabled: arg == null,
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
      buttonCondition(),
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
                icon: arg == null
                    ? FontAwesomeIcons.clockRotateLeft
                    : FontAwesomeIcons.qrcode,
                onPressed: () {
                  if (arg == null) {
                    Get.toNamed(Routes.CHECKHISTORY);
                  } else {
                    Get.toNamed(Routes.QRVIEW, arguments: {
                      'id': controller.main['id'],
                      'form_code': controller.main['form_code']
                    });
                  }
                },
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
