import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/controllers/auth_controller.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';

class LoginController extends AuthController {
  final usernameNode = FocusNode(), passwordNode = FocusNode();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isObscure = true.obs;

  void toggleObscure() {
    isObscure.value = !isObscure.value;
    update();
  }

  void nextNode() => passwordNode.requestFocus();

  void handleSubmit(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      Get.offAllNamed(Routes.HOME);
    } else {
      print('Form is invalid');
    }
  }
}
