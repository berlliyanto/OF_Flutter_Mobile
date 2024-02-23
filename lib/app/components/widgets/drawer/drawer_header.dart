import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';
import 'package:of_flutter_mobile/app/utils/url_files.dart';

Widget drawerHeader({required ColorPicker colors}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
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
        if (getUser()['image'] != "")
          CachedNetworkImage(
            imageUrl: urlImageBuilder(
                transaction: "show", type: "user", image: getUser()['image']),
            errorWidget: (context, url, error) {
              return Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: colors.grey.withOpacity(0.1),
                ),
                child: const Center(
                  child: Icon(
                    FontAwesomeIcons.triangleExclamation,
                    size: 20,
                  ),
                ),
              );
            },
            placeholder: (context, url) {
              return Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: colors.grey.withOpacity(0.1),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: colors.grey,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              );
            },
          )
        else
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
          text: getUser()['name'] ?? "",
          color: colors.whiteSmoke,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
        Paragraph(
          text: getUser()['role'] ?? "",
          color: colors.whiteSmoke,
        ),
        const Gap(20)
      ],
    ),
  );
}
