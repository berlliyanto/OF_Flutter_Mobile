import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/grid/grid.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/source/menu/submenu_list.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

class HumancapitalController extends GetxController {
  final ColorPicker colors = ColorPicker();
  final GlobalState globalState = Get.find<GlobalState>();

  List<Widget> renderMenu() {
    List<Widget> menu = [];
    for (var item in listHumanCapital) {
      menu.add(GridItem(
        title: item.title,
        image1: item.image1,
        colors: colors,
        image2: item.image2,
        routes: item.routes,
      ).animate().slideY(duration: const Duration(milliseconds: 500)));
    }

    return menu;
  }
}
