import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tileUser.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/components/widgets/tile/tile_user.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/modules/maintenance/controllers/myworkorder_controller.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyworkorderView extends GetView<MyworkorderController> {
  MyworkorderView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final GlobalState globalState = GlobalState();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List<Widget> body() {
    if (controller.isLoading.value) {
      return [
        skeletonTileUser(),
        const Gap(10),
        skeletonTileUser(),
        const Gap(10),
      ];
    }

    return controller.listWorkorder
        .map(
          (e) => tileUser(
            colors: colors,
            backgroundColor: tileColor(e.status!, e.isCanceled!, colors),
            name: "Name : ${e.userModel!.name!}",
            subtitle1: "Unit : ${e.forkliftModel!.unitCode!}",
            subtitle2: "Description : ${e.description}",
            image: e.userModel!.image ?? "",
            onTap: () {
              Get.toNamed(
                Routes.WORKORDER,
                arguments: {
                  'id': e.id,
                },
              );
            },
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "MY WORKORDER", colors: colors),
      extendBodyBehindAppBar: true,
      body: GetBuilder<MyworkorderController>(
        builder: (builder) {
          return BackgroundLayout(
            showBottom: false,
            showLogo: false,
            child: MainLayout(
              isScrollable: true,
              refreshController: refreshController,
              onRefresh: () async {
                await controller.myWO();
                refreshController.refreshCompleted();
              },
              children: [
                title(title: "My Work Order"),
                const Heading(heading: "h2", text: "Recent Workorder"),
                const Gap(10),
                ...body()
              ],
            ),
          );
        },
      ),
    );
  }
}

Color tileColor(String status, int isCanceled, ColorPicker colors) {
  if (status == "approved") {
    return colors.green.withOpacity(0.2);
  } else if (status == "proses") {
    return colors.yellow.withOpacity(0.2);
  } else if (status == "done") {
    if (isCanceled == 1) {
      return colors.red.withOpacity(0.2);
    }
    return colors.greenDark.withOpacity(0.8);
  } else {
    return colors.whiteSmoke;
  }
}
