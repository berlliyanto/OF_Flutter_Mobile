import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/controllers/auth_controller.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/models/user_model.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/services/auth/auth_service.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';

class LoginController extends AuthController {
  final globalState = Get.find<GlobalState>();
  final usernameNode = FocusNode(), passwordNode = FocusNode();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isObscure = true.obs;
  var isLoading = false.obs;

  void toggleObscure() {
    isObscure.value = !isObscure.value;
    update();
  }

  void nextNode() => passwordNode.requestFocus();

  void handleSubmit(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        "username": usernameController.text,
        "password": passwordController.text
      };
      isLoading.value = true;
      update();
      EasyLoading.show(status: "Login...");
      final response = await AuthService().login(data: data);
      if (response.data != null) {
        final UserModel userModel = UserModel.fromJson(response.data['data']);
        globalState.setPermissions = userModel.rolePermissions;
        setUser({
          "id": userModel.id,
          "name": userModel.name,
          "role": userModel.roles![0].name,
          "image": userModel.image ?? ""
        });
        setToken(response.data['token']);
        Get.offAllNamed(Routes.HOME);
      }
      EasyLoading.dismiss();
      isLoading.value = false;
      update();
    } else {
      toast(message: "Form is Invalid");
    }
  }
}
