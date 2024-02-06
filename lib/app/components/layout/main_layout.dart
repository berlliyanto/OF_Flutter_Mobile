import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MainLayout extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxis;
  final CrossAxisAlignment crossAxis;
  final double paddingLR;
  final bool isScrollable;
  final List<double> margins;
  final RefreshController? refreshController;
  final VoidCallback? onRefresh;
  final ScrollController? scrollController;
  const MainLayout(
      {required this.children,
      this.refreshController,
      this.onRefresh,
      this.mainAxis = MainAxisAlignment.start,
      this.crossAxis = CrossAxisAlignment.start,
      this.paddingLR = 15,
      this.isScrollable = false,
      this.margins = const [0, 0, 0, 0],
      this.scrollController,
      super.key});

  Widget mainScrollable() {
    if (isScrollable) {
      if (refreshController != null && onRefresh != null) {
        return SmartRefresher(
          controller: refreshController!,
          onRefresh: onRefresh,
          header: const WaterDropMaterialHeader(
            offset: 100,
            backgroundColor: Color(0xFF19A7CE),
            distance: 50,
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: paddingLR),
            children: children,
          ),
        );
      }
      return ListView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: paddingLR),
        children: children,
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingLR),
      margin:
          EdgeInsets.fromLTRB(margins[0], margins[1], margins[2], margins[3]),
      height: Get.height,
      width: Get.width,
      child: Column(
        mainAxisAlignment: mainAxis,
        crossAxisAlignment: crossAxis,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return mainScrollable();
  }
}
