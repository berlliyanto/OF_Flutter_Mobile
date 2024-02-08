import 'package:flutter/material.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

PreferredSizeWidget appBar({
  required String text,
  required ColorPicker colors,
  bool drawerLeading = false,
}) {
  dynamic leading() {
    // final arg = Get.arguments;
    // bool isRefresh = arg != null ? arg['isRefresh'] : false;
    if (!drawerLeading) {
      return null;
      // Builder(
      //   builder: (context) => IconButton(
      //     onPressed: () => Get.back(result: isRefresh),
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: colors.primaryBlack,
      //       size: 30,
      //     ),
      //   ),
      // );
    }

    return Builder(
      builder: (context) => IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(
          Icons.menu,
          size: 30,
          color: colors.primaryBlack,
        ),
      ),
    );
  }

  return AppBar(
      title: Paragraph(
        text: text,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      shadowColor: Colors.transparent,
      elevation: 0,
      backgroundColor: Colors.black.withOpacity(0.1),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colors.cyanDark,
              Colors.white30,
            ],
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      leading: leading());
}
