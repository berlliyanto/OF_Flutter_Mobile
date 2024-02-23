import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/button.dart';
import 'package:of_flutter_mobile/app/components/widgets/datatable/datatable.dart';
import 'package:of_flutter_mobile/app/components/widgets/datatable/datatable_header.dart';
import 'package:of_flutter_mobile/app/components/widgets/dropdown/single_dropdown_less.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_bigrectangle.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tile.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';
import 'package:of_flutter_mobile/app/utils/validator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/absencehistory_controller.dart';

class AbsencehistoryView extends GetView<AbsencehistoryController> {
  AbsencehistoryView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final GlobalState globalState = Get.find<GlobalState>();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List<Widget> body() {
    if (controller.isLoading.value) {
      return [
        skeletonTile(),
        const Gap(10),
        skeletonTile(),
        const Gap(10),
        skeletonTile(),
        const Gap(10),
        skeletonBigRectangle(),
      ];
    }

    String userRole = getUser()['role'];

    return [
      if (userRole != "Mekanik" && userRole != "Operator")
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextInput(
            colors: colors,
            onChanged: (value) => controller.onChange(value, 'name'),
            hint: "Search Name",
            controller: controller.searchNameController,
            withSuffix: true,
            suffixIcon: FontAwesomeIcons.magnifyingGlass,
          ),
        ),
      button(
          text: controller.period.value,
          colors: colors.whiteSmoke,
          borderColor: colors.primaryBlack,
          textColor: colors.primaryBlack,
          onPressed: () => controller.onPeriodPicked(Get.context!)),
      const Gap(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: singleDropdownLess(
              data: controller.paidLeaveTypes,
              hint: 'Paid Leave',
              width: Get.width,
              colors: colors,
              value: dropdownValue(controller.paidLeaveType.value),
              onChanged: (value) => controller.onChange(value, 'paidLeaveType'),
            ),
          ),
          const Gap(10),
          Expanded(
            child: singleDropdownLess(
              data: controller.statusList,
              hint: 'Status',
              width: Get.width,
              colors: colors,
              value: dropdownValue(controller.statusId.value),
              onChanged: (value) => controller.onChange(value, 'status'),
            ),
          ),
        ],
      ),
      const Gap(10),
      if (checkQueryIsExist(controller.activeQuery.value,
          ["name", "paid_leave_type_id", "status", "month"]))
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
          "Tanggal Dibuat",
          "Nama",
          "Jenis Cuti",
          "From",
          "To",
          "Total Hari",
          "Keterangan",
          "Status",
          "Tanggal Approve SPV",
          "Tanggal Approve User",
          "Tanggal Approve Management",
          "Actions"
        ]),
        source: controller.source,
        rowsPerPage: controller.perPage.value,
        availableRowsPerPage: [10, 25, 50],
        onPageChanged: (value) => controller.onPageChanged(value),
        onRowsPerPageChanged: (value) =>
            controller.onRowsPerPageChanged(value!),
      ),
      const Gap(10),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "LEAVE HISTORY", colors: colors),
      extendBodyBehindAppBar: true,
      body: GetBuilder<AbsencehistoryController>(
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
                  title: "Leave History",
                  withLeading: globalState.getPermissions
                      .contains("export-checklist-excel"),
                  icon: FontAwesomeIcons.solidFileExcel,
                  iconColor: Colors.green,
                  onPressed: () => builder.handleExport(),
                ),
                const Gap(10),
                ...body(),
              ],
            ),
          );
        },
      ),
    );
  }
}
