import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/gradient_button.dart';
import 'package:of_flutter_mobile/app/components/widgets/dialog/awesome_dialog.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tileUser.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/components/widgets/tile/tile_user.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/modules/humancapital/controllers/employee_controller.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EmployeeView extends GetView<EmployeeController> {
  EmployeeView({Key? key}) : super(key: key);

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

    return controller.employees.map((e) {
      return Dismissible(
        onDismissed: (direction) {
          awesomeDialog(
              title: "Are you sure to delete ${e.name}?",
              desc:
                  "All record related to this employee will be deleted (checklist, leave, salary, user account, etc)",
              cancel: () async =>
                  await controller.getEmployees("page=1&per_page=10"),
              onDismissCallback: (T) async =>
                  await controller.getEmployees("page=1&per_page=10"),
              callback: () => controller.deleteUser(e.userModel!.id!),
              type: DialogType.question);
        },
        direction: DismissDirection.endToStart,
        background: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.centerRight,
          child: const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        key: Key(e.userModel!.id.toString()),
        child: tileUser(
          colors: colors,
          name: e.name!,
          subtitle1: "Annual Leave : ${e.annualLeaveAllowance!}",
          subtitle2: "Status Employee : ${capitalizeFirstChar(e.status!)}",
          image: e.userModel!.image ?? "",
          onTap: () {
            if (!globalState.getPermissions
                .contains("update-employee-allowance")) {
              return;
            }
            Get.toNamed(
              Routes.USERPROFILE,
              arguments: {
                'id': e.userModel!.id.toString(),
              },
            );
          },
          onLongPress: () {
            controller.annualLeaveController.text =
                e.annualLeaveAllowance.toString();
            if (!globalState.getPermissions
                .contains("update-employee-allowance")) {
              return;
            }
            Get.bottomSheet(
              Container(
                padding: const EdgeInsets.all(15),
                height: 180,
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
                    const Heading(heading: "h2", text: "Annual Leave"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () =>
                              controller.handleOnChange("1", "min"),
                          icon: const Icon(
                            FontAwesomeIcons.minus,
                            size: 28,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: TextInput(
                            controller: controller.annualLeaveController,
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.center,
                            colors: colors,
                            onChanged: (value) {},
                            hint: "Input Annual Leave",
                          ),
                        ),
                        const Gap(10),
                        IconButton(
                          onPressed: () =>
                              controller.handleOnChange("1", "add"),
                          icon: const Icon(
                            FontAwesomeIcons.plus,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    GradientButton(
                        colors: [colors.green, colors.greenDark],
                        onPressed: () =>
                            controller.updateAnnualLeaveAllowance(e.id!),
                        text: "Update")
                  ],
                ),
              ),
            );
          },
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "EMPLOYEES", colors: colors),
      extendBodyBehindAppBar: true,
      body: GetBuilder<EmployeeController>(
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
                  title: "Employees",
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
