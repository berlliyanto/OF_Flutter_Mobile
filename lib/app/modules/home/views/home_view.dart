import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/drawer/drawer.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/components/widgets/tile/tile.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/source/menu/home_list.dart';
import 'package:of_flutter_mobile/app/utils/greeting.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final GlobalState globalState = Get.find<GlobalState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "Home", colors: colors, drawerLeading: true),
      extendBodyBehindAppBar: true,
      extendBody: true,
      drawer: drawer(
        name: controller.name.value,
        roleName: controller.roleName.value,
        colors: colors,
        currentActiveMenu: "Home",
        onTap: (route) => globalState.handleDrawerMenu(route),
      ),
      body: GetBuilder<HomeController>(builder: (builder) {
        return BackgroundLayout(
          showBottom: true,
          showTop: false,
          showLogo: true,
          child: MainLayout(
            refreshController: refreshController,
            onRefresh: () {
              refreshController.refreshCompleted();
            },
            isScrollable: true,
            children: <Widget>[
              title(title: "${greeting()}, ${builder.name.value}", size: 22),
              const Gap(20),
              SizedBox(
                width: Get.width,
                child: Column(
                  children: listHome.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    return Tile(
                      routes: data.routes,
                      title: data.title,
                      icon: data.icon,
                      colors: colors,
                      paddingHV: const [10, 10],
                      animationDuration: (index * 200) + 600,
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
