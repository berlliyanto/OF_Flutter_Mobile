import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/button.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/gradient_button.dart';
import 'package:of_flutter_mobile/app/components/widgets/dropdown/single_dropdown_less.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/horizontal_label_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tile.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_twintile.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/modules/humancapital/controllers/absencerequest_controller.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';
import 'package:of_flutter_mobile/app/utils/validator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AbsencerequestView extends GetView<AbsencerequestController> {
  AbsencerequestView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final GlobalState globalState = Get.find<GlobalState>();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final arg = Get.arguments;

  List<Color> getStatus(String status) {
    switch (status) {
      case "Requested":
        return [colors.cyan, colors.cyanDark];
      case "On Process":
        return [colors.yellow, colors.yellowDark];
      case "Approved":
        return [colors.green, colors.greenDark];
      case "Rejected":
        return [colors.red, colors.redDark];
      default:
        return [colors.primaryBlack, colors.primaryBlack];
    }
  }

  Widget buildStatus() {
    if (arg == null) {
      return const SizedBox();
    }
    List<Color> color = getStatus(controller.status.value);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      width: Get.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Heading(
          heading: "h2",
          text: controller.status.value,
          color: colors.whiteSmoke,
        ),
      ),
    );
  }

  List<Widget> buildApproval() {
    if (arg == null) {
      return [];
    }

    return [
      const Heading(heading: "h1", text: "Approval"),
      const Gap(10),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: colors.cyanDark,
            radius: 8,
          ),
          const Gap(5),
          const Heading(
            heading: "h2",
            text: "Supervisor Approval Date :",
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Heading(
          heading: "h3",
          text: controller.spvApproval.value,
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
            text: "User Approval Date :",
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Heading(
          heading: "h3",
          text: controller.userApproval.value,
        ),
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
            text: "Management Approval Date :",
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Heading(
          heading: "h3",
          text: controller.managementApproval.value,
        ),
      ),
    ];
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
        skeletonTile(),
        const Gap(10),
        skeletonTile(),
        const Gap(10),
        skeletonTile(),
        const Gap(10),
      ];
    }

    return [
      buildStatus(),
      if (controller.status.value == "Rejected")
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Heading(
              heading: "h3",
              text: "Rejected By : ${controller.rejectedBy.value}"),
        ),
      horizontalLabelInput(
        label: "Name",
        child: TextInput(
          isEnabled: arg == null,
          controller: controller.nameController,
          width: Get.width,
          colors: colors,
          onChanged: (value) {},
          hint: "Name",
        ),
        animationDuration: 200,
      ),
      const Gap(10),
      horizontalLabelInput(
          label: "Paid Leave",
          child: singleDropdownLess(
            data: controller.paidLeaveTypes,
            hint: "Paid Leave",
            width: Get.width,
            colors: colors,
            value: dropdownValue(controller.paidLeaveTypeValue.value),
            onChanged: (val) =>
                arg != null ? null : controller.onChange("paidLeaveType", val),
          ),
          animationDuration: 250),
      const Gap(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Heading(
                heading: "h2", text: "Date", textAlign: TextAlign.start),
          ),
          Expanded(
            child: button(
                colors: colors.whiteSmoke,
                borderColor: colors.primaryBlack,
                textColor: colors.primaryBlack,
                onPressed: () =>
                    arg != null && getUser()['role'] != "Management"
                        ? null
                        : controller.getDate(Get.context!, "start"),
                textSize: 16,
                fontWeight: FontWeight.normal,
                text: controller.formattedStartDate.value),
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
                    arg != null && getUser()['role'] != "Management"
                        ? null
                        : controller.getDate(Get.context!, "end"),
                textSize: 16,
                fontWeight: FontWeight.normal,
                text: controller.formattedEndDate.value),
          ),
        ],
      ).animate().slideY(duration: 350.ms),
      const Gap(10),
      horizontalLabelInput(
          label: "Total Days",
          child: TextInput(
            isEnabled: false,
            controller: controller.totalDaysController,
            keyboardType: TextInputType.number,
            width: Get.width,
            colors: colors,
            onChanged: (value) {},
            hint: "Total Days",
          ),
          animationDuration: 400),
      const Gap(10),
      TextInput(
        isEnabled: arg == null,
        label: "Reason",
        controller: controller.reasonController,
        colors: colors,
        onChanged: (val) {},
        hint: "Reason",
        keyboardType: TextInputType.multiline,
        maxLines: arg != null ? 5 : null,
        onTapOutside: (pointer) =>
            FocusManager.instance.primaryFocus?.unfocus(),
      ).animate().slideY(duration: 450.ms),
      const Gap(10),
      if (arg == null &&
          globalState.getPermissions.contains('create-paidleave'))
        GradientButton(
          colors: [colors.soekimanPallet1, colors.soekimanPallet2],
          onPressed: () => controller.handleSend(),
          text: "Send",
        ),
      if (arg != null &&
          globalState.getPermissions.contains('approve-paidleave'))
        GradientButton(
          colors: [colors.green, colors.greenDark],
          onPressed: () => controller.approveAction("approved", arg['id']),
          text: "Approve",
        ),
      const Gap(10),
      if (arg != null &&
          globalState.getPermissions.contains('approve-paidleave'))
        GradientButton(
          colors: [colors.red, colors.redDark],
          onPressed: () =>
              controller.approveOrReject({"status": "rejected"}, arg['id']),
          text: "Reject",
        ),
      ...buildApproval()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "LEAVE REQUEST", colors: colors),
      extendBodyBehindAppBar: true,
      body: GetBuilder<AbsencerequestController>(
        builder: (builder) {
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
                  title: "Leave Request",
                ),
                const Gap(10),
                ...body()
              ],
            ),
          );
        },
      ),
    );
  }
}
