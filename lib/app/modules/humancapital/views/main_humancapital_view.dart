import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/drawer/drawer.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

import '../controllers/main_humancapital_controller.dart';

class HumancapitalView extends GetView<HumancapitalController> {
  HumancapitalView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final GlobalState globalState = Get.find<GlobalState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBar(text: "HUMAN CAPITAL", colors: colors, drawerLeading: true),
      extendBodyBehindAppBar: true,
      drawer: drawer(
        colors: colors,
        currentActiveMenu: "Human Capital",
        onTap: (route) => globalState.handleDrawerMenu(route),
      ),
      body: GetBuilder<HumancapitalController>(builder: (builder) {
        return BackgroundLayout(
          child: MainLayout(
            children: [
              title(title: "Human Capital"),
              const Gap(10),
              Expanded(
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.5),
                  children: builder.renderMenu(),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
