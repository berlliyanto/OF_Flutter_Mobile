import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/controllers/auth_controller.dart';

class RegisterController extends AuthController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isObscure = true.obs;

  void toggleObscure() {
    isObscure.value = !isObscure.value;
    update();
  }

  void handleSubmit(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }
}
