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
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/validator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/maintenancehistory_controller.dart';

class MaintenancehistoryView extends GetView<MaintenancehistoryController> {
  MaintenancehistoryView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final GlobalState globalState = Get.find<GlobalState>();
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  List<Widget> body() {
    if (controller.isLoading.value) {
      return [
        skeletonTile(),
        const Gap(10),
        skeletonTile(),
        const Gap(10),
        skeletonBigRectangle(),
        const Gap(10)
      ];
    }

    return [
      TextInput(
        colors: colors,
        onChanged: (value) => controller.onChange("unitCode", value),
        hint: "Search Unit Code",
        withSuffix: true,
        suffixIcon: FontAwesomeIcons.magnifyingGlass,
        controller: controller.searchUnitCodeController,
      ).animate().slideY(duration: 200.ms),
      const Gap(10),
      button(
              text: controller.period.value,
              onPressed: () => controller.onPeriodPicked(Get.context!),
              borderColor: colors.primaryBlack,
              textColor: colors.primaryBlack,
              colors: colors.whiteSmoke)
          .animate()
          .slideY(duration: 250.ms),
      const Gap(10),
      if (checkQueryIsExist(
          controller.activeQuery.value, ["unitCode", "month"]))
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
            "Dibuat Pada",
            "Dibuat Oleh",
            "Kode Unit",
            "Deskripsi",
            "Status",
            "Verifikasi Supervisor",
            "Mulai Inspeksi",
            "Catatan Inspeksi Awal",
            "Selesai Perbaikan",
            "Catatan Perbaikan Akhir",
            "Unit Breakdown(Jam)",
            "Actions",
          ]),
          source: controller.source,
          rowsPerPage: controller.perPage.value,
          onPageChanged: (value) => controller.onPageChanged(value),
          onRowsPerPageChanged: (value) =>
              controller.onRowsPerPageChanged(value!),
          availableRowsPerPage: [10, 25, 50]).animate().fade(duration: 300.ms),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(text: "HISTORY", colors: colors),
        extendBodyBehindAppBar: true,
        body: GetBuilder<MaintenancehistoryController>(
          builder: (builder) {
            return BackgroundLayout(
              showBottom: false,
              showLogo: false,
              child: MainLayout(
                isScrollable: true,
                refreshController: refreshController,
                onRefresh: () async => controller.onRefresh(refreshController),
                children: [
                  title(
                    title: "Maintenance History",
                    withLeading: globalState.getPermissions
                        .contains("export-workorder-excel"),
                    icon: FontAwesomeIcons.solidFileExcel,
                    iconColor: Colors.green,
                    onPressed: () => builder.handleExport(),
                  ),
                  const Gap(10),
                  ...body(),
                  const Gap(10),
                ],
              ),
            );
          },
        ));
  }
}
