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
import 'package:of_flutter_mobile/app/components/widgets/dropdown/search_dropdown.dart';
import 'package:of_flutter_mobile/app/components/widgets/dropdown/single_dropdown_less.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/checkhistory_controller.dart';

class CheckhistoryView extends GetView<CheckhistoryController> {
  CheckhistoryView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

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
                refreshController.refreshCompleted();
              },
              children: [
                title(
                  title: "Checklist History",
                  withLeading: true,
                  icon: FontAwesomeIcons.solidFileExcel,
                  iconColor: Colors.green,
                  onPressed: () {},
                ).animate().slideY(duration: 150.ms, begin: -0.1, end: 0),
                const Gap(10),
                TextInput(
                  width: Get.width,
                  colors: colors,
                  onChanged: (value) {},
                  hint: "Search",
                  withSuffix: true,
                  suffixIcon: FontAwesomeIcons.magnifyingGlass,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus!.unfocus(),
                ).animate().slideY(),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: singleDropdownLess(
                        data: [
                          {'id': 1, 'name': 'Option 1'},
                          {'id': 2, 'name': 'Option 2'},
                          {'id': 3, 'name': 'Option 3'},
                        ],
                        hint: "Location",
                        width: Get.width,
                        colors: colors,
                        value: builder.locationId.value == 0
                            ? null
                            : builder.locationId,
                        onChanged: (value) =>
                            builder.onChangedInput("location", value),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (v) {},
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
                    return await builder.suggestions(pattern);
                  },
                  onSelected: (data) => builder.onTypeAheadSelected(data!),
                  textEditingController: builder.textController,
                ).animate().slideY(),
                const Gap(10),
                dataTable(
                  dataColumns: datatableHeader([
                    "No",
                    "Kode Form",
                    "Tanggal Checklist",
                    "Kode Unit",
                    "Hour Meter",
                    "Operator",
                    "Shift",
                    "Jumlah Pallet",
                    "Verifikasi Supervisor",
                    "Verifikasi User",
                    "Action"
                  ]),
                  source: builder.source,
                  rowsPerPage: 10,
                ).animate().fade(),
                const Gap(10)
              ],
            ),
          );
        },
      ),
    );
  }
}
