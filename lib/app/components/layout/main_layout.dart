import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainLayout extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxis;
  final CrossAxisAlignment crossAxis;
  final double paddingLR;
  final bool isScrollable;
  final List<double> margins;
  const MainLayout(
      {required this.children,
      this.mainAxis = MainAxisAlignment.center,
      this.crossAxis = CrossAxisAlignment.center,
      this.paddingLR = 10,
      this.isScrollable = false,
      this.margins = const [0, 0, 0, 0],
      super.key});

  Widget mainScrollable({required Widget child}) {
    if (isScrollable) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: paddingLR),
        margin:
            EdgeInsets.fromLTRB(margins[0], margins[1], margins[2], margins[3]),
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: child,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingLR),
      margin:
          EdgeInsets.fromLTRB(margins[0], margins[1], margins[2], margins[3]),
      height: Get.height,
      width: Get.width,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return mainScrollable(
      child: Column(
        mainAxisAlignment: mainAxis,
        crossAxisAlignment: crossAxis,
        children: children,
      ),
    );
  }
}
