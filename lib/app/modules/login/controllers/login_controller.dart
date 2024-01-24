import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/constant/color.dart';

class LoginController extends GetxController {
  ColorPicker colorPicker = ColorPicker();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLogoVisible = true.obs;
  var isObscure = true.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void toggleObscure() {
    isObscure.value = !isObscure.value;
    update();
  }

  void hideLogoOnFocus() {
    isLogoVisible.value = false;
    update();
  }

  void showLogoOnUnfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
    isLogoVisible.value = true;
    update();
  }

  void handleSubmit() {
    if (formKey.currentState!.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }
}
