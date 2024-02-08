import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/modules/checkunit/controllers/checkreport_detail_controller.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CheckreportDetailView extends GetView<CheckreportDetailController> {
  CheckreportDetailView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final arg = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "CHECK REPORT DETAIL", colors: colors),
      extendBodyBehindAppBar: true,
      body: GetBuilder<CheckreportDetailController>(
        builder: (builder) {
          return BackgroundLayout(
            showBottom: false,
            showLogo: false,
            child: MainLayout(
              isScrollable: true,
              refreshController: refreshController,
              onRefresh: () async {
                refreshController.refreshCompleted();
              },
              children: [
                title(
                  title: "Check Report Detail",
                  withLeading: true,
                  icon: FontAwesomeIcons.qrcode,
                  iconColor: colors.cyanDark,
                  onPressed: () {},
                ),
                // Paragraph(text: "${arg['id']}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
