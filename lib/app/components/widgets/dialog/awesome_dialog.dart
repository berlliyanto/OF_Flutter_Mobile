import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void awesomeDialog(
    {required String title,
    required String desc,
    DialogType type = DialogType.info,
    Widget? body,
    VoidCallback? callback,
    cancel}) {
  AwesomeDialog(
          context: Get.context!,
          animType: AnimType.scale,
          dialogType: type,
          useRootNavigator: true,
          title: title,
          desc: desc,
          btnOkOnPress: callback,
          btnCancelOnPress: cancel,
          showCloseIcon: true,
          body: body)
      .show();
}
