import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tileUser.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/components/widgets/tile/tile_user.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/modules/checkunit/controllers/mychecklist_controller.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MychecklistView extends GetView<MychecklistController> {
  MychecklistView({Key? key}) : super(key: key);
  final ColorPicker colors = ColorPicker();
  final GlobalState globalState = Get.find<GlobalState>();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List<Widget> body() {
    if (controller.isLoading.value) {
      return [
        skeletonTileUser(),
        const Gap(10),
        skeletonTileUser(),
        const Gap(10),
        skeletonTileUser(),
      ];
    }

    return controller.listChecklist.map((e) {
      return tileUser(
          colors: colors,
          name: e.unitCode!,
          subtitle1: "Form Code : ${e.formCode!}",
          subtitle2:
              "Created : ${e.createdAt != null ? formatDate(e.createdAt) : '-'}",
          image: e.forklift!.image ?? "",
          type: "forklift",
          onTap: () {
            Get.toNamed(Routes.CHECKREPORT, arguments: {"id": e.id});
          });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(text: "MY CHECKLIST", colors: colors),
        extendBodyBehindAppBar: true,
        body: GetBuilder<MychecklistController>(
          builder: (builder) {
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
                  title(title: "Unfinish Checklist"),
                  const Gap(10),
                  ...body(),
                ],
              ),
            );
          },
        ));
  }
}
