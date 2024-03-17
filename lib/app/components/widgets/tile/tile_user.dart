import 'package:cached_network_image/cached_network_image.dart';
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
    Color backgroundColor = const Color(0xFFF5F5F5),
    String subtitle1 = "",
    dynamic subtitle2 = "",
    dynamic image,
    String transaction = "show",
    String type = "user",
    VoidCallback? onTap,
    VoidCallback? onLongPress}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    width: Get.width,
    decoration: BoxDecoration(
      color: backgroundColor,
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
        onLongPress: onLongPress,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image != "")
                CachedNetworkImage(
                  imageUrl: urlImageBuilder(
                      transaction: transaction, type: type, image: image),
                  errorWidget: (context, url, error) {
                    return Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
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
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: colors.grey.withOpacity(0.1),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: colors.grey,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    );
                  },
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
                    Paragraph(text: subtitle1),
                    Paragraph(text: subtitle2),
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
