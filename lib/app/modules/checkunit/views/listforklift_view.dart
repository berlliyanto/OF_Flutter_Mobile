import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/datatable/datatable.dart';
import 'package:of_flutter_mobile/app/components/widgets/datatable/datatable_header.dart';
import 'package:of_flutter_mobile/app/components/widgets/dropdown/single_dropdown_less.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_bigrectangle.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tile.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_twintile.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/modules/checkunit/controllers/addunit_controller.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/validator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/listforklift_controller.dart';

class ListforkliftView extends GetView<ListforkliftController> {
  ListforkliftView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List<Widget> body() {
    if (controller.isLoading.value) {
      return [
        skeletonTile(),
        const Gap(10),
        skeletonTwinTile(),
        const Gap(10),
        skeletonBigRectangle()
      ];
    }

    return [
      TextInput(
        controller: controller.searchController,
        keyboardType: TextInputType.streetAddress,
        width: Get.width,
        colors: colors,
        withSuffix: true,
        suffixIcon: FontAwesomeIcons.magnifyingGlass,
        onChanged: (value) => controller.handleOnChange(value, "unit_code"),
        hint: "Search Unit Code",
        onTapOutside: (pointer) => controller.handleOnUnFocus(pointer),
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
                value: controller.location.value == 0
                    ? null
                    : controller.location.value,
                onChanged: (value) =>
                    controller.handleOnChange(value, "location_id")),
          ).animate().slideX(begin: -1, end: 0),
          const Gap(10),
          Expanded(
            child: singleDropdownLess(
              data: controller.listPic,
              hint: "PIC",
              width: Get.width,
              colors: colors,
              value: controller.pic.value == 0 ? null : controller.pic.value,
              onChanged: (value) => controller.handleOnChange(value, "pic_id"),
            ),
          ).animate().slideX(begin: 1, end: 0),
        ],
      ),
      const Gap(10),
      if (checkQueryIsExist(
          controller.query.value, ["unit_code", "pic_id", "location_id"]))
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
        dataColumns: datatableHeader(
          ["No", "Unit Code", "Location", "Hour Mtr", "PIC", "Action"],
        ),
        source: controller.source,
        rowsPerPage: controller.meta.perPage,
        onPageChanged: (value) => controller.onPageChanged(value),
        onRowsPerPageChanged: (value) =>
            controller.onRowsPerPageChanged(value!),
      ).animate().fade(),
      const Gap(10)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBar(text: "LIST FORKLIFT", colors: colors, drawerLeading: false),
      extendBodyBehindAppBar: true,
      body: GetBuilder<ListforkliftController>(builder: (builder) {
        return PopScope(
          onPopInvoked: (didPop) {
            if (Get.isRegistered<AddunitController>()) {
              final controller = Get.find<AddunitController>();
              controller.reset();
            }
          },
          child: BackgroundLayout(
            showBottom: false,
            showLogo: false,
            child: MainLayout(
              isScrollable: true,
              refreshController: refreshController,
              onRefresh: () async {
                await builder.fetchAllData();
                refreshController.refreshCompleted();
              },
              children: [
                title(
                  title: "List Forklift",
                  withLeading: true,
                  onPressed: () {},
                  icon: FontAwesomeIcons.solidFileExcel,
                  iconColor: Colors.green,
                ).animate().slideY(duration: 150.ms, begin: -0.1, end: 0),
                const Gap(10),
                ...body()
              ],
            ),
          ),
        );
      }),
    );
  }
}
