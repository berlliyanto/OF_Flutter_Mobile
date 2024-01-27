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
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/constant/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/listforklift_controller.dart';

class ListforkliftView extends GetView<ListforkliftController> {
  ListforkliftView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBar(text: "LIST FORKLIFT", colors: colors, drawerLeading: false),
      extendBodyBehindAppBar: true,
      body: GetBuilder<ListforkliftController>(builder: (builder) {
        return BackgroundLayout(
          showBottom: false,
          showLogo: false,
          child: MainLayout(
            isScrollable: true,
            refreshController: refreshController,
            onRefresh: () async {
              refreshController.refreshCompleted();
            },
            children: [
              title(
                title: "List Forklift",
                withLeading: true,
                onPressed: () {},
                icon: FontAwesomeIcons.solidFileExcel,
                iconColor: Colors.green,
              ).animate().slideY(),
              const Gap(10),
              TextInput(
                keyboardType: TextInputType.streetAddress,
                width: Get.width,
                colors: colors,
                withSuffix: true,
                suffixIcon: Icons.search,
                onChanged: (value) {},
                hint: "Search Unit Code",
                onTap: () => builder.handleOnFocus(),
                onTapOutside: (pointer) => builder.handleOnUnFocus(pointer),
              ).animate().slideY(),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: singleDropdownLess(
                        data: [
                          {'id': 1, 'name': 'SOE'},
                          {'id': 2, 'name': 'CKU'}
                        ],
                        hint: "Location",
                        width: Get.width,
                        colors: colors,
                        value: null,
                        onChanged: (value) {}),
                  ).animate().slideX(begin: -1, end: 0),
                  const Gap(10),
                  Expanded(
                    child: singleDropdownLess(
                      data: [
                        {'id': 1, 'name': 'SOE'},
                        {'id': 2, 'name': 'CKU'}
                      ],
                      hint: "PIC",
                      width: Get.width,
                      colors: colors,
                      value: null,
                      onChanged: (value) {},
                    ),
                  ).animate().slideX(begin: 1, end: 0),
                ],
              ),
              const Gap(10),
              dataTable(
                dataColumns: datatableHeader(
                  ["No", "Unit Code", "Location", "Hour Mtr", "PIC", "Action"],
                ),
                source: builder.source,
                rowsPerPage: builder.perPage.value,
              ).animate().fade(),
            ],
          ),
        );
      }),
    );
  }
}
