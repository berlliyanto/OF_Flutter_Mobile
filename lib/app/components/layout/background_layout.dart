import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/shape/positioned_shape.dart';
import 'package:of_flutter_mobile/app/components/widgets/shape/shape.dart';
import 'package:of_flutter_mobile/app/constant/color.dart';

class BackgroundLayout extends StatelessWidget {
  final Widget child;
  final bool showBottom, showLogo;
  BackgroundLayout(
      {required this.child,
      required this.showBottom,
      this.showLogo = true,
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
              colors: [Colors.grey.shade300, Colors.white],
            ),
          ),
        ),
        positionedShape(
          left: -100,
          top: -200,
          child: Hero(
            tag: 'shape1',
            child: Shape(
                shape: "circle", color: colors.grey, height: 300, width: 300),
          ),
        ),
        positionedShape(
          left: 190,
          top: -250,
          child: Hero(
            tag: 'shape2',
            child: Shape(
                shape: "circle", color: colors.black, height: 300, width: 300),
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
                  color: colors.black,
                  height: 500,
                  width: 500),
            ),
          ),
        if (showLogo)
          Positioned(
            left: Get.width / 2 - 40,
            bottom: 40,
            child: const Hero(
              tag: 'soekiman',
              child: Image(
                image: AssetImage("assets/images/logo-auth.png"),
              ),
            ),
          ),
        child
      ],
    );
  }
}
