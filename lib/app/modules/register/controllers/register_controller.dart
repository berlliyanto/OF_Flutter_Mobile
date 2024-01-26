import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/controllers/auth_controller.dart';

class RegisterController extends AuthController {
  final usernameNode = FocusNode(),
      nameNode = FocusNode(),
      emailNode = FocusNode(),
      passwordNode = FocusNode();

  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isObscure = true.obs;

  void nextNode(String node) {
    switch (node) {
      case "name":
        emailNode.requestFocus();
        break;
      case "email":
        usernameNode.requestFocus();
        break;
      case "username":
        passwordNode.requestFocus();
        break;
    }
  }

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
