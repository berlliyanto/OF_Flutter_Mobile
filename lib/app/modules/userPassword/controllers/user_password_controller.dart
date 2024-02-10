import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/snackbar/snackbar.dart';
import 'package:of_flutter_mobile/app/services/user/user_service.dart';

class UserPasswordController extends GetxController {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final newPasswordNode = FocusNode(), confirmPasswordNode = FocusNode();

  var isObscureNew = true.obs;
  var isObscureConfirm = true.obs;

  void toggleObscure(String type) {
    if (type == "new") {
      isObscureNew.value = !isObscureNew.value;
    } else if (type == "confirm") {
      isObscureConfirm.value = !isObscureConfirm.value;
    }
    update();
  }

  void handleUpdatePassword(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> data = {};
      data["password"] = confirmPasswordController.text;

      EasyLoading.show(status: "Loading...");
      final response = await UserService().updatePassword(data: data);
      if (response.data != null) {
        snackbar(
          title: "Success",
          message: response.data["message"],
          type: "success",
        );

        newPasswordController.clear();
        confirmPasswordController.clear();
      }
      update();
      EasyLoading.dismiss();
    } else {
      snackbar(
        title: "Failed",
        message: "Form is not valid",
        type: "error",
      );
    }
  }
}
