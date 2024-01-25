import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/constant/color.dart';

class AuthController extends GetxController {
  ColorPicker colorPicker = ColorPicker();
  var isLogoVisible = true.obs;

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
