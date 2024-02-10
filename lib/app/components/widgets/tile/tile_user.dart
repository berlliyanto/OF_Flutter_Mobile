import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/url_files.dart';

Widget tileUser(
    {required ColorPicker colors,
    required String name,
    String manHour = "",
    dynamic lastCheck = "",
    dynamic image,
    VoidCallback? onTap}) {
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
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image != "")
                CircleAvatar(
                  backgroundColor: colors.primaryBlack.withOpacity(0.2),
                  backgroundImage: NetworkImage(
                    urlImageBuilder(
                        transaction: "show", type: "user", image: image),
                  ),
                  radius: 30,
                )
              else
                CircleAvatar(
                  backgroundColor: colors.primaryBlack.withOpacity(0.2),
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
                    Paragraph(text: manHour),
                    Paragraph(text: lastCheck),
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
