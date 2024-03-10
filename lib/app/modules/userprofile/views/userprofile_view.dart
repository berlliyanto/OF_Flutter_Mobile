import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/gradient_button.dart';
import 'package:of_flutter_mobile/app/components/widgets/datatable/datatable.dart';
import 'package:of_flutter_mobile/app/components/widgets/datatable/datatable_header.dart';
import 'package:of_flutter_mobile/app/components/widgets/drawer/drawer.dart';
import 'package:of_flutter_mobile/app/components/widgets/image/image.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_circle.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tile.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/userprofile_controller.dart';

class UserprofileView extends GetView<UserprofileController> {
  UserprofileView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final GlobalState globalState = Get.find<GlobalState>();
  final arg = Get.arguments;

  Widget buttonCondition() {
    if (arg == null) {
      if (globalState.getPermissions.contains("update-profile")) {
        return GradientButton(
            colors: [colors.green, colors.greenDark],
            onPressed: () => controller.handleUpdate(),
            text: "Update");
      } else {
        return const SizedBox();
      }
    } else {
      if (globalState.getPermissions.contains("update-user")) {
        return GradientButton(
            colors: [colors.green, colors.greenDark],
            onPressed: () => controller.handleUpdate(),
            text: "Update");
      } else {
        return const SizedBox();
      }
    }
  }

  List<Widget> body() {
    if (controller.isLoading.value) {
      return [
        skeletonCircle(),
        const Gap(10),
        skeletonTile(),
        const Gap(10),
        skeletonTile(),
        const Gap(10),
        skeletonTile(),
        const Gap(10)
      ];
    }

    return [
      imageCard(
          url: controller.createUrlImage(),
          fileImage: controller.image,
          additionalText: "Image",
          height: Get.width * 0.25,
          width: Get.width * 0.25,
          margins: [Get.width * 0.34, 0, Get.width * 0.34, 0],
          onTap: () {
            if (arg == null) {
              if (globalState.getPermissions.contains("update-profile")) {
                controller.openSheetImage();
              }
            } else {
              if (globalState.getPermissions.contains("update-user")) {
                controller.openSheetImage();
              }
            }
          },
          colors: colors,
          iconSize: 24,
          fontSize: 16,
          radius: 50),
      const Gap(10),
      TextInput(
          controller: controller.nameController,
          label: "Name",
          width: Get.width,
          colors: colors,
          onChanged: (val) {},
          hint: "Name..."),
      const Gap(10),
      TextInput(
          controller: controller.emailController,
          label: "Email",
          width: Get.width,
          colors: colors,
          onChanged: (val) {},
          onTapOutside: (pointer) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          hint: "Email..."),
      const Gap(10),
      Row(
        children: [
          Expanded(
            child: TextInput(
                isEnabled: false,
                controller: controller.roleController,
                label: "Role",
                width: Get.width,
                colors: colors,
                onChanged: (val) {},
                hint: "Role..."),
          ),
          const Gap(10),
          Expanded(
            child: TextInput(
                isEnabled: false,
                controller: controller.leaveController,
                label: "Annual Leave",
                width: Get.width,
                colors: colors,
                onChanged: (val) {},
                hint: "Annual Leave..."),
          ),
        ],
      ),
      const Gap(10),
      buttonCondition(),
      const Gap(10),
      if (globalState.getPermissions.contains("reset-password") && arg != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GradientButton(
              colors: [colors.yellow, colors.yellowDark],
              onPressed: () => controller.resetPassword(),
              text: "Reset Password"),
        ),
      if (controller.userModel.roles![0].name == "Operator" ||
          controller.userModel.roles![0].name == "Supervisor")
        const Heading(heading: "h2", text: "Checklists Unit"),
      if (controller.userModel.roles![0].name == "Operator" ||
          controller.userModel.roles![0].name == "Supervisor")
        dataTable(
          dataColumns: datatableHeader([
            "No",
            "Kode Form",
            "Tanggal Checklist",
            "Kode Unit",
            "Hour Meter",
            "Actual Hour Meter",
            "Operator",
            "Shift",
            "Lokasi",
            "Jumlah Pallet",
            "Man Hour",
            "Ratio",
            "Verifikasi Supervisor",
            "Verifikasi Management",
            "Verifikasi User",
            "Action"
          ]),
          source: controller.source,
          rowsPerPage: 10,
          availableRowsPerPage: [10, 25, 50, 100],
          onPageChanged: (value) => controller.onPageChanged(value),
          onRowsPerPageChanged: (value) =>
              controller.onRowsPerPageChanged(value!),
        ).animate().fade(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          text: arg == null ? "PROFILE" : "EMPLOYEE",
          colors: colors,
          drawerLeading: arg == null),
      extendBodyBehindAppBar: true,
      drawer: arg != null
          ? null
          : drawer(
              colors: colors,
              currentActiveMenu: "Profile",
              onTap: (route) => globalState.handleDrawerMenu(route)),
      body: GetBuilder<UserprofileController>(builder: (builder) {
        return BackgroundLayout(
          showBottom: false,
          showLogo: false,
          child: MainLayout(
            crossAxis: CrossAxisAlignment.center,
            refreshController: refreshController,
            onRefresh: () async {
              await builder.getUserProfile();
              refreshController.refreshCompleted();
            },
            isScrollable: true,
            children: [
              title(title: "", withTitle: false),
              ...body(),
              const Gap(10),
            ],
          ),
        );
      }),
    );
  }
}
