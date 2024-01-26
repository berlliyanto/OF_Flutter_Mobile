import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/shape/positioned_shape.dart';
import 'package:of_flutter_mobile/app/components/widgets/shape/shape.dart';
import 'package:of_flutter_mobile/app/constant/color.dart';

class BackgroundLayout extends StatelessWidget {
  final bool showBottom, showLogo, showTop;
  final Widget child;
  BackgroundLayout(
      {this.showBottom = true,
      this.showTop = false,
      this.showLogo = true,
      required this.child,
      super.key});

  final colors = ColorPicker();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFFF5F5F5), Colors.grey.shade300],
            ),
          ),
        ),
        if (showTop)
          positionedShape(
            left: -100,
            top: -200,
            child: Hero(
              tag: 'shape1',
              child: Shape(
                  shape: "circle", color: colors.grey, height: 300, width: 300),
            ),
          ),
        if (showTop)
          positionedShape(
            left: 190,
            top: -250,
            child: Hero(
              tag: 'shape2',
              child: Shape(
                  shape: "circle",
                  color: colors.cyanDark,
                  height: 300,
                  width: 300),
            ),
          ),
        if (showBottom)
          positionedShape(
            left: Get.width - 200,
            top: Get.height - 190,
            child: Hero(
              tag: 'shape3',
              child: Shape(
                  shape: "circle", color: colors.grey, height: 300, width: 300),
            ),
          ),
        if (showBottom)
          positionedShape(
            left: -200,
            top: Get.height - 120,
            child: Hero(
              tag: 'shape4',
              child: Shape(
                  shape: "circle",
                  color: colors.cyanDark,
                  height: 500,
                  width: 500),
            ),
          ),
        if (showLogo)
          Positioned(
            left: Get.width / 2 - 40,
            bottom: 40,
            child: Hero(
              tag: 'soekiman',
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo-pt.png"),
                  ),
                ),
              ),
            ),
          ),
        child
      ],
    );
  }
}
