import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

Widget tileUser(
    {required ColorPicker colors,
    required String name,
    required String role,
    String createdAt = ""}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    width: Get.width,
    decoration: BoxDecoration(
      color: colors.whiteSmoke,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(width: 1, color: colors.primaryBlack),
      boxShadow: [
        BoxShadow(
          color: colors.primaryBlack.withOpacity(0.1),
          blurRadius: 10,
        )
      ],
    ),
    child: Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: colors.grey.withOpacity(0.2),
                radius: 30,
                child: const Icon(
                  FontAwesomeIcons.userAstronaut,
                  size: 30,
                ),
              ),
              const Gap(20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Paragraph(text: name),
                    Paragraph(text: role),
                    Paragraph(text: createdAt),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
