import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/tile/tile.dart';
import 'package:of_flutter_mobile/app/constant/color.dart';
import 'package:of_flutter_mobile/app/data/home_list.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "Home", colors: colors),
      extendBodyBehindAppBar: true,
      drawer: const Drawer(),
      body: GetBuilder<HomeController>(builder: (builder) {
        return BackgroundLayout(
          showBottom: true,
          showTop: false,
          showLogo: false,
          child: MainLayout(
            mainAxis: MainAxisAlignment.start,
            crossAxis: CrossAxisAlignment.start,
            children: <Widget>[
              const Gap(120),
              const Heading(
                  heading: "h1",
                  text: "Welcome, User",
                  textAlign: TextAlign.start),
              const Gap(20),
              SizedBox(
                width: Get.width,
                child: Column(
                  children: listHome
                      .map(
                        (e) => Tile(
                            routes: e.routes,
                            title: e.title,
                            icon: e.icon,
                            colors: colors),
                      )
                      .toList(),
                ),
              )
            ],
          ).animate().fade(duration: 600.ms),
        );
      }),
    );
  }
}
