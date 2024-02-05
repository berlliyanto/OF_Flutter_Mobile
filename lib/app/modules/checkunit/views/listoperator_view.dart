import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/listoperator_controller.dart';

class ListoperatorView extends GetView<ListoperatorController> {
  ListoperatorView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

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
              isScrollable: true,
              refreshController: refreshController,
              onRefresh: () {
                refreshController.refreshCompleted();
              },
              children: [
                title(title: "List Operator"),
                const Gap(10),
                TextInput(
                  controller: controller.searchController,
                  keyboardType: TextInputType.streetAddress,
                  width: Get.width,
                  colors: colors,
                  withSuffix: true,
                  suffixIcon: FontAwesomeIcons.magnifyingGlass,
                  onChanged: (value) => controller.handleOnChange(value),
                  hint: "Search Name",
                ).animate().slideY(),
              ],
            ),
          );
        },
      ),
    );
  }
}
