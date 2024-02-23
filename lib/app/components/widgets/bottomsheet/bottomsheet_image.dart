import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

bottomSheetImage(
    {required VoidCallback onTapCamera,
    required VoidCallback onTapGallery,
    required ColorPicker colors}) {
  return Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(15),
      height: 120,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            width: Get.width,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTapCamera,
                child: Row(
                  children: [
                    const Icon(Icons.camera_alt,
                        size: 32, color: Colors.blueGrey),
                    const Gap(5),
                    Paragraph(
                      text: "Camera",
                      color: colors.primaryBlack,
                      fontSize: 16,
                    )
                  ],
                ),
              ),
            ),
          ),
          const Gap(10),
          Container(
            color: Colors.white,
            width: Get.width,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTapGallery,
                child: Row(
                  children: [
                    const Icon(Icons.image, size: 32, color: Colors.blueGrey),
                    const Gap(5),
                    Paragraph(
                      text: "Gallery",
                      color: colors.primaryBlack,
                      fontSize: 16,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
  );
}
