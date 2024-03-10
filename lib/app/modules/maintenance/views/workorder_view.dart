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
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_rectangle.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tile.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/modules/maintenance/controllers/workorder_controller.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WorkorderView extends GetView<WorkorderController> {
  WorkorderView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final GlobalState globalState = Get.find<GlobalState>();
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );
  final arg = Get.arguments;

  Widget titleCondition() {
    if (arg != null &&
        globalState.getPermissions.contains('delete-workorder')) {
      return title(
        title: "Work Order",
        withLeading: true,
        icon: FontAwesomeIcons.trash,
        iconColor: colors.red,
        onPressed: () => controller.onDeleteWO(),
      );
    }

    return title(title: "Work Order");
  }

  Widget buttonCondition() {
    if (arg != null) {
      if (globalState.getPermissions.contains('cancel-workorder') &&
          controller.workorderModel.status == "created") {
        return GradientButton(
          colors: [colors.red, colors.redDark],
          onPressed: () => controller.onCancelWO(),
          text: "Cancel Workorder",
        );
      }
      if (globalState.getPermissions.contains('verify-workorder')) {
        if (getUser()['role'] == "Supervisor") {
          if (controller.workorderModel.verificationSupervisor != null) {
            return button(
                text: "Supervisor has approved this Workorder",
                onPressed: () {},
                textColor: colors.primaryBlack.withOpacity(0.5),
                borderColor: colors.primaryBlack.withOpacity(0.5));
          }
          return GradientButton(
            colors: [colors.green, colors.greenDark],
            onPressed: () => controller.onVerify(),
            text: "Verify",
          );
        }

        if (controller.workorderModel.status == "created") {
          return button(
              text: "Supervisor has not verified",
              onPressed: () {},
              textColor: colors.primaryBlack.withOpacity(0.5),
              borderColor: colors.primaryBlack.withOpacity(0.5));
        }

        if (controller.workorderModel.status != "done") {
          return GradientButton(
            colors: [colors.green, colors.greenDark],
            onPressed: () {
              if (controller.workorderModel.startTimeInspection == null) {
                controller.onVerify();
              } else {
                controller.onFinish();
              }
            },
            text: "Submit",
          );
        }
        return const Gap(0);
      }

      return const Gap(0);
    }

    return GradientButton(
      colors: [colors.soekimanPallet1, colors.soekimanPallet2],
      onPressed: () => controller.onOrder(),
      text: "Order",
    );
  }

  List<Widget> searchDropdownCondition() {
    if (arg != null) {
      return [
        const Heading(heading: "h2", text: "Forklift Unit"),
        const Gap(5),
        TextInput(
          colors: colors,
          onChanged: (val) {},
          hint: controller.workorderModel.forkliftModel!.unitCode ?? "",
          isEnabled: false,
        ),
      ];
    }

    return [
      const Heading(heading: "h2", text: "Select Forklift Unit"),
      const Gap(5),
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

  List<Widget> startInspectionInput() {
    if (arg != null) {
      if (globalState.getPermissions.contains('cancel-workorder') &&
          controller.workorderModel.status == "created") {
        return [
          const Gap(10),
          TextInput(
            isEnabled: controller.workorderModel.startTimeInspection == null,
            label: "Reason",
            colors: colors,
            onChanged: (value) {},
            hint: "Input Reason",
            controller: controller.cancelWOReasonController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ];
      }

      if (getUser()['role'] == "Supervisor" &&
          controller.workorderModel.status == "created") {
        return [];
      }

      return [
        const Divider(),
        const Heading(heading: "h2", text: "Start Inspection"),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: button(
                  colors: colors.whiteSmoke,
                  text: controller.formattedStartDate.value,
                  onPressed: () {
                    if (controller.workorderModel.status == "approved") {
                      controller.onChange("date", "start");
                    }
                  },
                  textColor: colors.primaryBlack,
                  borderColor: colors.primaryBlack),
            ),
            const Gap(10),
            Expanded(
              child: button(
                  colors: colors.whiteSmoke,
                  text: controller.formattedStartTime.value,
                  onPressed: () {
                    if (controller.workorderModel.status == "approved") {
                      controller.onChange("time", "start");
                    }
                  },
                  textColor: colors.primaryBlack,
                  borderColor: colors.primaryBlack),
            ),
          ],
        ),
        const Gap(10),
        TextInput(
          isEnabled: controller.workorderModel.startTimeInspection == null,
          label: "Notes",
          colors: colors,
          onChanged: (value) {},
          hint: "Input Notes",
          controller: controller.firstInspectionNoteController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
        const Gap(10),
      ];
    }

    return [];
  }

  List<Widget> endInspectionInput() {
    if (arg != null && controller.workorderModel.startTimeInspection != null) {
      return [
        const Divider(),
        const Heading(heading: "h2", text: "Repair Completed"),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: button(
                  colors: colors.whiteSmoke,
                  text: controller.formattedEndDate.value,
                  onPressed: () => controller.onChange("date", "end"),
                  textColor: colors.primaryBlack,
                  borderColor: colors.primaryBlack),
            ),
            const Gap(10),
            Expanded(
              child: button(
                  colors: colors.whiteSmoke,
                  text: controller.formattedEndTime.value,
                  onPressed: () => controller.onChange("time", "end"),
                  textColor: colors.primaryBlack,
                  borderColor: colors.primaryBlack),
            ),
          ],
        ),
        const Gap(10),
        TextInput(
          isEnabled: controller.workorderModel.endTimeInspection == null,
          label: "Notes",
          colors: colors,
          onChanged: (value) {},
          hint: "Input Notes",
          controller: controller.endInspectionNoteController,
          keyboardType: TextInputType.multiline,
        ),
        const Gap(10),
      ];
    }

    return [];
  }

  List<Widget> showUnitBreakDown() {
    if (arg != null) {
      if (controller.workorderModel.status == "done") {
        return [
          const Divider(),
          const Heading(heading: "h2", text: "Unit Breakdown (Hour)"),
          const Gap(10),
          TextInput(
            isEnabled: false,
            colors: colors,
            onChanged: (Value) {},
            hint: controller.workorderModel.unitBreakdown!,
          ),
          const Gap(10),
        ];
      }

      return [];
    }

    return [];
  }

  List<Widget> bodyCondition() {
    if (controller.workorderModel.isCanceled == 1) {
      return [
        const Gap(10),
        Heading(
          heading: "h2",
          text: "Work Order Canceled",
          color: colors.red,
        ),
        const Gap(10),
        TextInput(
          maxLines: 5,
          colors: colors,
          onChanged: (val) {},
          hint: controller.workorderModel.canceledNote ?? "",
          isEnabled: false,
          label: "Reason",
        )
      ];
    }

    return [
      ...startInspectionInput(),
      ...endInspectionInput(),
      ...showUnitBreakDown(),
    ];
  }

  List<Widget> body() {
    if (controller.isLoading.value) {
      return [
        skeletonTile(),
        const Gap(10),
        skeletonRectangle(),
        const Gap(10),
        skeletonTile(),
      ];
    }

    return [
      ...searchDropdownCondition(),
      const Gap(10),
      const Heading(heading: "h2", text: "Description"),
      const Gap(5),
      TextInput(
        isEnabled: arg == null,
        colors: colors,
        onChanged: (value) {},
        keyboardType: TextInputType.multiline,
        hint: "Input Description",
        controller: controller.descriptionController,
        maxLines: 5,
      ),
      ...bodyCondition(),
      const Gap(10),
      buttonCondition(),
      const Gap(10),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "WORK ORDER", colors: colors),
      extendBodyBehindAppBar: true,
      body: GetBuilder<WorkorderController>(builder: (builder) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BackgroundLayout(
            showLogo: false,
            showBottom: false,
            child: MainLayout(
              isScrollable: true,
              refreshController: refreshController,
              onRefresh: () async {
                await controller.fetchAllAPI();
                refreshController.refreshCompleted();
              },
              children: [
                titleCondition(),
                const Gap(10),
                ...body(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
