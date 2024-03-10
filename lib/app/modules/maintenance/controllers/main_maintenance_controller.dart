import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/grid/grid.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/source/menu/submenu_list.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

class MaintenanceController extends GetxController {
  final GlobalState globalState = Get.find<GlobalState>();
  final ColorPicker colors = ColorPicker();

  List<Widget> renderMenu() {
    List<Widget> menu = [];
    for (var item in listMaintenance) {
      if (globalState.getPermissions.contains(item.permissions)) {
        menu.add(GridItem(
          title: item.title,
          image1: item.image1,
          colors: colors,
          image2: item.image2,
          routes: item.routes,
        ).animate().slideY(duration: const Duration(milliseconds: 500)));
      }
    }

    return menu;
  }
}
