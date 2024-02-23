import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tileUser.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/components/widgets/tile/tile_approval.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/modules/humancapital/controllers/approval_controller.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ApprovalView extends GetView<ApprovalController> {
  ApprovalView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final GlobalState globalState = Get.find<GlobalState>();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List<Widget> body() {
    if (controller.isLoading.value) {
      return [
        skeletonTileUser(),
        skeletonTileUser(),
        skeletonTileUser(),
        skeletonTileUser(),
      ];
    }

    if (controller.listPaidLeave.isEmpty) {
      return [
        const Center(
          child: Heading(heading: "h2", text: "There's Nothing to Approve"),
        )
      ];
    }

    return controller.listPaidLeave.map((e) {
      return tileApproval(
        colors: colors,
        name: e.employee!.name!,
        image: e.employee!.userModel!.image ?? "",
        totalDays: e.totalDays.toString(),
        paidLeaveType: e.paidLeaveTypeModel!.name!,
        onDetail: () =>
            Get.toNamed(Routes.ABSENCEREQUEST, arguments: {"id": e.id}),
        onApprove: () => controller.approveOrReject("approved", e.id!),
        onReject: () => controller.approveOrReject("rejected", e.id!),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "APPROVAL", colors: colors),
      extendBodyBehindAppBar: true,
      body: GetBuilder<ApprovalController>(
        builder: (builder) {
          return BackgroundLayout(
            showBottom: false,
            showLogo: false,
            child: MainLayout(
              isScrollable: true,
              refreshController: refreshController,
              onRefresh: () => builder.refreshData(refreshController),
              scrollController: builder.scrollController,
              children: [
                title(
                  title: "Approval",
                  withLeading: true,
                  icon: builder.sort.value == "asc"
                      ? FontAwesomeIcons.arrowDownAZ
                      : FontAwesomeIcons.arrowUpAZ,
                  onPressed: () {
                    if (builder.sort.value == "asc") {
                      builder.sort.value = "desc";
                    } else {
                      builder.sort.value = "asc";
                    }
                    builder.handleOnChange(builder.sort.value, "sort");
                  },
                ),
                const Gap(10),
                TextInput(
                  controller: controller.searchNameController,
                  keyboardType: TextInputType.streetAddress,
                  width: Get.width,
                  colors: colors,
                  withSuffix: true,
                  suffixIcon: FontAwesomeIcons.magnifyingGlass,
                  onChanged: (value) =>
                      controller.handleOnChange(value, "name"),
                  hint: "Search Name",
                ).animate().slideY(),
                const Gap(10),
                ...body(),
                if (builder.loadingScroll.value)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                const Gap(10),
              ],
            ),
          );
        },
      ),
    );
  }
}
