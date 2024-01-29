import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/controllers/auth_controller.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/services/auth/auth_service.dart';

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
  var isLoading = false.obs;

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

  void handleSubmit(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        "username": usernameController.text,
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text
      };
      EasyLoading.show(status: "Register...");
      isLoading.value = true;
      update();
      final response = await AuthService().register(data: data);
      if (response.data != null) {
        EasyLoading.showSuccess(response.data['message']);
        Get.offAllNamed(Routes.LOGIN);
      }
      isLoading.value = false;
      update();
      EasyLoading.dismiss();
    } else {
      toast(message: "Form is Invalid");
    }
  }
}
