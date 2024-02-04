import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

Widget imageCard({
  File? fileImage,
  String? url,
  required double height,
  required double width,
  required VoidCallback onTap,
  required ColorPicker colors,
  List<double> margins = const [0, 0, 0, 0],
  double fontSize = 30,
  double iconSize = 70,
  String additionalText = '',
}) {
  Widget image() {
    if (fileImage != null) {
      return Image.file(fileImage, fit: BoxFit.fill);
    }

    if (fileImage == null && url == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.add_a_photo,
            size: iconSize,
            color: colors.cyanDark,
          ),
          const Gap(10),
          Heading(
              heading: "h1",
              size: fontSize,
              text: "Tap to add image $additionalText",
              textAlign: TextAlign.center),
        ],
      );
    }

    return CachedNetworkImage(
      imageUrl: url!,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const Center(
        child: Text("Loading..."),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        size: 50,
      ),
    );
  }

  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin:
          EdgeInsets.fromLTRB(margins[0], margins[1], margins[2], margins[3]),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: fileImage != null ? Colors.transparent : colors.whiteSmoke,
        border: Border.all(color: colors.primaryBlack),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: image(),
        ),
      ),
    ),
  );
}
