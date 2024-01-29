import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

Widget drawerHeader({required ColorPicker colors}) {
  return Container(
    height: 200,
    width: Get.width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [colors.cyan, colors.cyanDark],
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: colors.primaryBlack,
          child: Icon(
            FontAwesomeIcons.userAstronaut,
            color: colors.whiteSmoke,
            size: 25,
          ),
        ),
        const Gap(5),
        Paragraph(
          text: "User",
          color: colors.whiteSmoke,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        Paragraph(
          text: "Supervisor",
          color: colors.whiteSmoke,
        ),
        const Gap(20)
      ],
    ),
  );
}
