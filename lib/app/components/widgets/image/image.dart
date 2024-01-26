import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/constant/color.dart';

class ImageCard extends StatelessWidget {
  final double width, height, fontSize;
  final File? fileImage;
  final dynamic url;
  final VoidCallback onTap;
  final ColorPicker colors;
  final List<double> margins;

  const ImageCard(
      {this.fileImage,
      this.url,
      required this.height,
      required this.width,
      required this.onTap,
      required this.colors,
      this.margins = const [0, 0, 0, 0],
      this.fontSize = 30,
      super.key});

  dynamic imageFromFile() {
    if (url != null || url != "" || fileImage == null) {
      return null;
    }

    return DecorationImage(image: FileImage(fileImage!), fit: BoxFit.fill);
  }

  Widget imageFromAPI() {
    if (fileImage != null && url == null) {
      return const SizedBox();
    }

    if (fileImage == null && url == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.add_a_photo,
            size: 70,
            color: colors.cyanDark,
          ),
          const Gap(20),
          Heading(
              heading: "h1",
              size: fontSize,
              text: "Tap to add image",
              textAlign: TextAlign.center),
        ],
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:
            EdgeInsets.fromLTRB(margins[0], margins[1], margins[2], margins[3]),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors.whiteSmoke,
          image: imageFromFile(),
          border: Border.all(color: colors.primaryBlack),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: imageFromAPI(),
          ),
        ),
      ),
    );
  }
}
