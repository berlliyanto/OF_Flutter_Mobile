import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/grid/grid.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/constant/color.dart';
import 'package:of_flutter_mobile/app/source/menu/checkunit_list.dart';

import '../controllers/main_checkunit_controller.dart';

class ChechkunitView extends GetView<ChechkunitController> {
  ChechkunitView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          text: "FORKLIFT CHECK UNIT", colors: colors, drawerLeading: true),
      extendBodyBehindAppBar: true,
      drawer: const Drawer(),
      body: GetBuilder<ChechkunitController>(builder: (context) {
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
                  children: listCheckUnit.map((e) {
                    return GridItem(
                      title: e.title,
                      image1: e.image1,
                      colors: colors,
                      image2: e.image2,
                      routes: e.routes,
                    )
                        .animate()
                        .slideY(duration: const Duration(milliseconds: 500));
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
