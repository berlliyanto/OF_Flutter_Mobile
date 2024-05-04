import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tileUser.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/components/widgets/tile/tile_user.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/modules/maintenance/controllers/listworkorder_controller.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListworkorderView extends GetView<ListworkorderController> {
  ListworkorderView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final GlobalState globalState = Get.find<GlobalState>();
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  List<Widget> tiles() {
    if (controller.isLoading.value) {
      return [
        skeletonTileUser(),
        const Gap(10),
        skeletonTileUser(),
        const Gap(10),
      ];
    }

    return controller.listWorkOrder.isEmpty
        ? [
            const Center(
              child: Heading(heading: "h2", text: "No Data"),
            )
          ]
        : (controller.listWorkOrder
            .map(
              (e) => tileUser(
                colors: colors,
                name: "Name : ${e.userModel!.name!}",
                subtitle1: "Unit : ${e.forkliftModel!.unitCode!}",
                subtitle2: "Problem : ${e.description}",
                image: e.userModel!.image ?? "",
                onTap: () {
                  if (globalState.getPermissions.contains('verify-workorder')) {
                    Get.toNamed(
                      Routes.WORKORDER,
                      arguments: {
                        'id': e.id,
                      },
                    );
                  }
                },
              ),
            )
            .toList());
  }

  List<Widget> body() {
    return [
      SizedBox(
        height: 40,
        child: GridView.count(
          padding: EdgeInsets.zero,
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 4,
          children: controller.listStatus
              .map(
                (e) => GestureDetector(
                  onTap: () => controller.onChange("status", e['name']),
                  child: AnimatedContainer(
                    duration: 300.ms,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: controller.activeStatus.value == e['name']
                          ? e['color']
                          : colors.whiteSmoke,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.primaryBlack),
                    ),
                    child: Paragraph(
                      text: capitalizeFirstChar(e['name']),
                      fontWeight: FontWeight.bold,
                      color: controller.activeStatus.value == e['name']
                          ? colors.whiteSmoke
                          : colors.primaryBlack,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      TextInput(
        colors: colors,
        onChanged: (value) => controller.onChange("unitCode", value),
        hint: "Search Unit Code",
        controller: controller.searchUnitCodeController,
      ),
      const Divider(),
      ...tiles()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "LIST WORK ORDER", colors: colors),
      extendBodyBehindAppBar: true,
      body: GetBuilder<ListworkorderController>(builder: (builder) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BackgroundLayout(
            showBottom: false,
            showLogo: false,
            child: MainLayout(
              isScrollable: true,
              refreshController: refreshController,
              onRefresh: () async => builder.refreshData(refreshController),
              scrollController: controller.scrollController,
              children: [
                title(title: "List Work Order"),
                const Gap(10),
                ...body(),
                if (builder.loadingScroll.value)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                const Gap(10),
              ],
            ),
          ),
        );
      }),
    );
  }
}
