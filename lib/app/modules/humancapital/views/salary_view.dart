import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/button.dart';
import 'package:of_flutter_mobile/app/components/widgets/datatable/datatable.dart';
import 'package:of_flutter_mobile/app/components/widgets/datatable/datatable_header.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_bigrectangle.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tile.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/modules/humancapital/controllers/salary_controller.dart';
import 'package:of_flutter_mobile/app/modules/humancapital/local_widgets/bottomsheet_file.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SalaryView extends GetView<SalaryController> {
  SalaryView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final GlobalState globalState = Get.find<GlobalState>();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  dynamic floatingActionButton() {
    if (globalState.getPermissions.contains('create-salary')) {
      return FloatingActionButton(
        onPressed: () => bottomSheetFileUpload(
          colors: colors,
          suggestionsCallback: (pattern) async =>
              await controller.suggestions(pattern),
          onSelected: (data) => controller.onTypeAheadSelected(data!),
          searchDropdownController: controller.searchDropDownController,
          textFileController: controller.textFileController,
          scrollController: controller.scrollControllerSearchDropdown,
          onFileSelected: () => controller.onFileSelected(),
          onSubmit: () => controller.onSubmit(),
          onCancel: controller.onCloseBottomSheet,
        ),
        backgroundColor: colors.soekimanPallet1,
        child: const Icon(FontAwesomeIcons.fileArrowUp, color: Colors.white),
      );
    }

    return null;
  }

  List<Widget> body() {
    if (controller.isLoading.value) {
      return [
        skeletonTile(),
        const Gap(10),
        skeletonTile(),
        const Gap(10),
        skeletonBigRectangle()
      ];
    }

    return [
      button(
        text: controller.period.value,
        colors: colors.whiteSmoke,
        borderColor: colors.primaryBlack,
        textColor: colors.primaryBlack,
        onPressed: () => controller.onPeriodPicked(Get.context!),
      ).animate().slideY(),
      const Gap(10),
      TextInput(
        controller: controller.searchNameController,
        keyboardType: TextInputType.streetAddress,
        width: Get.width,
        colors: colors,
        withSuffix: true,
        suffixIcon: FontAwesomeIcons.magnifyingGlass,
        onChanged: (value) => controller.handleOnChange(value, "employee"),
        hint: "Search Name",
      ).animate().slideY(),
      const Gap(10),
      dataTable(
        dataColumns: datatableHeader(["No", "Tanggal", "Name", "Actions"]),
        source: controller.source,
        rowsPerPage: controller.perPage.value,
        availableRowsPerPage: [10, 25, 50],
        onPageChanged: (value) => controller.onPageChanged(value),
        onRowsPerPageChanged: (value) =>
            controller.onRowsPerPageChanged(value!),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "SALARY SLIP", colors: colors),
      extendBodyBehindAppBar: true,
      body: GetBuilder<SalaryController>(builder: (context) {
        return BackgroundLayout(
          showLogo: false,
          showBottom: false,
          child: MainLayout(
            isScrollable: true,
            refreshController: refreshController,
            onRefresh: () async {
              refreshController.refreshCompleted();
            },
            children: [
              title(title: "Salary Slip"),
              const Gap(10),
              ...body(),
              const Gap(10)
            ],
          ),
        );
      }),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
