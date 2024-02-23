import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/url_files.dart';

Widget tileApproval(
    {required ColorPicker colors,
    required String name,
    String totalDays = "",
    String paidLeaveType = "",
    dynamic image,
    VoidCallback? onApprove,
    VoidCallback? onReject,
    VoidCallback? onDetail}) {
  return Container(
    padding: const EdgeInsets.all(10),
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
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                  Paragraph(text: "Total Days : $totalDays"),
                  Paragraph(text: "Leave Type : $paidLeaveType"),
                ],
              ),
            )
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onDetail,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: colors.cyanDark,
                    borderRadius: BorderRadius.circular(5)),
                child: const Paragraph(
                  text: "Detail",
                  color: Colors.white,
                ),
              ),
            ),
            const Gap(10),
            GestureDetector(
              onTap: onApprove,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: colors.greenDark,
                    borderRadius: BorderRadius.circular(5)),
                child: const Paragraph(
                  text: "Approve",
                  color: Colors.white,
                ),
              ),
            ),
            const Gap(10),
            GestureDetector(
              onTap: onReject,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: colors.redDark,
                    borderRadius: BorderRadius.circular(5)),
                child: const Paragraph(
                  text: "Reject",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
