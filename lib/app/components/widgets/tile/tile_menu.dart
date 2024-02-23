import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

class TileMenu extends StatelessWidget {
  final String routes, title;
  final IconData icon;
  final ColorPicker colors;
  final List<double> paddingHV;
  final double animationDuration;
  const TileMenu(
      {required this.routes,
      required this.title,
      required this.icon,
      required this.colors,
      this.paddingHV = const [10, 5],
      this.animationDuration = 600,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(routes),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(
            horizontal: paddingHV[0], vertical: paddingHV[1]),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: colors.whiteSmoke,
            border: Border.all(color: colors.cyanDark, width: 2),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: colors.black.withOpacity(0.1),
                  offset: const Offset(3, 3),
                  blurRadius: 5)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Heading(heading: "h2", text: title, textAlign: TextAlign.start),
            Icon(icon, size: 30, color: colors.cyanDark),
          ],
        ),
      ).animate().slideX(duration: animationDuration.ms).fade(),
    );
  }
}
