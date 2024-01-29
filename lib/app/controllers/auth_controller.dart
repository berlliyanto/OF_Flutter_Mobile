import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

class AuthController extends GetxController {
  ColorPicker colorPicker = ColorPicker();
  var isLogoVisible = true.obs;

  RxList<Color> colorsLoading = <Color>[
    const Color.fromARGB(255, 66, 65, 65),
    const Color.fromARGB(255, 59, 58, 58),
  ].obs;

  void hideLogoOnFocus() {
    isLogoVisible.value = false;
    update();
  }

  void showLogoOnUnfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
    isLogoVisible.value = true;
    update();
  }
}
