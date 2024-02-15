import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/drawer/drawer.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';

import '../controllers/main_checkunit_controller.dart';

class ChechkunitView extends GetView<ChechkunitController> {
  ChechkunitView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final GlobalState globalState = Get.find<GlobalState>();

  dynamic floatingButtonQr() {
    if (getUser()["role"] == "User" ||
        getUser()["role"] == "Administrator" ||
        getUser()["role"] == "Supervisor" ||
        getUser()["role"] == "Management") {
      return FloatingActionButton(
        onPressed: () {
          controller.scanQR();
        },
        child: const Icon(
          FontAwesomeIcons.expand,
          size: 28,
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          text: "FORKLIFT CHECK UNIT", colors: colors, drawerLeading: true),
      extendBodyBehindAppBar: true,
      drawer: drawer(
        colors: colors,
        currentActiveMenu: "Forklift Check Unit",
        onTap: (route) => globalState.handleDrawerMenu(route),
      ),
      body: GetBuilder<ChechkunitController>(builder: (builder) {
        return BackgroundLayout(
          child: MainLayout(
            children: <Widget>[
              title(title: "Forklift Check Unit"),
              const Gap(20),
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
      floatingActionButton: floatingButtonQr(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
