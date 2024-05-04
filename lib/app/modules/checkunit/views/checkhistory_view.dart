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
import 'package:of_flutter_mobile/app/components/widgets/dropdown/search_dropdown.dart';
import 'package:of_flutter_mobile/app/components/widgets/dropdown/single_dropdown_less.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_bigrectangle.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tile.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/validator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/checkhistory_controller.dart';

class CheckhistoryView extends GetView<CheckhistoryController> {
  CheckhistoryView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final GlobalState globalState = Get.find<GlobalState>();

  List<Widget> body() {
    if (controller.isLoading.value) {
      return [
        skeletonTile(),
        const Gap(10),
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: singleDropdownLess(
              data: controller.listLocation,
              hint: "Location",
              width: Get.width,
              colors: colors,
              value: dropdownValue(controller.valueLocation.value),
              onChanged: (value) {
                if (!controller.isAllLocationChecked.value) {
                  controller.onChangedInput("location", value);
                }
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: controller.isAllLocationChecked.value,
                onChanged: (value) =>
                    controller.onChangedInput("all_location", value),
              )
            ],
          )
        ],
      ).animate().slideY(),
      const Gap(10),
      searchDropdown(
        hint: "Select Forklift Unit",
        colors: colors,
        suggestionsCallback: (pattern) async {
          return await controller.suggestions(pattern);
        },
        onSelected: (data) => controller.onTypeAheadSelected(data!),
        textEditingController: controller.unitController,
      ).animate().slideY(),
      const Gap(10),
      if (checkQueryIsExist(
          controller.activeQuery.value, ["search", "location_id", "unit_code"]))
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => controller.resetQuery(),
              child: Paragraph(
                text: "Clear ",
                color: colors.primaryBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
        rowsPerPage: controller.perPage.value,
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
          text: "CHECKLIST HISTORY", colors: colors, drawerLeading: false),
      extendBodyBehindAppBar: true,
      body: GetBuilder<CheckhistoryController>(
        builder: (builder) {
          return BackgroundLayout(
            showLogo: false,
            showBottom: false,
            child: MainLayout(
              isScrollable: true,
              refreshController: refreshController,
              onRefresh: () async {
                await builder.fetchAllAPI();
                refreshController.refreshCompleted();
              },
              children: [
                title(
                  title: "Checklist History",
                  withLeading: globalState.getPermissions
                      .contains("export-checklist-excel"),
                  icon: FontAwesomeIcons.solidFileExcel,
                  iconColor: Colors.green,
                  onPressed: () => builder.handleExport(),
                ).animate().slideY(duration: 150.ms, begin: -0.1, end: 0),
                const Gap(10),
                ...body(),
                const Gap(10)
              ],
            ),
          );
        },
      ),
    );
  }
}
