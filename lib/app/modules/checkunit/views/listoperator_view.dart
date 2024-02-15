import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/skeleton/skeleton_tileUser.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/components/widgets/tile/tile_user.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/listoperator_controller.dart';

class ListoperatorView extends GetView<ListoperatorController> {
  ListoperatorView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List<Widget> body() {
    if (controller.isLoading.value) {
      return [
        skeletonTileUser(),
        skeletonTileUser(),
        skeletonTileUser(),
        skeletonTileUser(),
        skeletonTileUser(),
        skeletonTileUser(),
        skeletonTileUser(),
        skeletonTileUser(),
      ];
    }

    return controller.operators.map((e) {
      return tileUser(
          colors: colors,
          name: e.name!,
          manHour: e.manHour!,
          lastCheck: e.lastChecklist ?? "No checklist yet",
          image: e.image ?? "",
          onTap: () {
            if (getUser()["role"] == "User" || getUser()["role"] == "Mekanik") {
              return;
            }
            Get.toNamed(
              Routes.USERPROFILE,
              arguments: {
                'id': e.id.toString(),
              },
            );
          });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "LIST OPERATOR", colors: colors),
      extendBodyBehindAppBar: true,
      body: GetBuilder<ListoperatorController>(
        builder: (builder) {
          return BackgroundLayout(
            showBottom: false,
            showLogo: false,
            child: MainLayout(
              scrollController: builder.scrollController,
              isScrollable: true,
              refreshController: refreshController,
              onRefresh: () => builder.refreshData(refreshController),
              children: [
                title(
                  title: "List Operator",
                  withLeading: true,
                  icon: builder.sort.value == "asc"
                      ? FontAwesomeIcons.arrowDownAZ
                      : FontAwesomeIcons.arrowUpAZ,
                  onPressed: () {
                    if (builder.sort.value == "asc") {
                      builder.sort.value = "desc";
                    } else {
                      builder.sort.value = "asc";
                    }
                    builder.handleOnChange(builder.sort.value, "sort");
                  },
                ),
                const Gap(10),
                TextInput(
                  controller: controller.searchController,
                  keyboardType: TextInputType.streetAddress,
                  width: Get.width,
                  colors: colors,
                  withSuffix: true,
                  suffixIcon: FontAwesomeIcons.magnifyingGlass,
                  onChanged: (value) =>
                      controller.handleOnChange(value, "search"),
                  hint: "Search Name",
                ).animate().slideY(),
                const Gap(10),
                ...body(),
                if (builder.loadingScroll.value)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                const Gap(10),
              ],
            ),
          );
        },
      ),
    );
  }
}
