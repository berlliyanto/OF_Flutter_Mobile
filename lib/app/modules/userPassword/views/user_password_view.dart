import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/gradient_button.dart';
import 'package:of_flutter_mobile/app/components/widgets/drawer/drawer.dart';
import 'package:of_flutter_mobile/app/components/widgets/form/form_auth.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/password_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/title.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

import '../controllers/user_password_controller.dart';

class UserPasswordView extends GetView<UserPasswordController> {
  UserPasswordView({Key? key}) : super(key: key);

  final colors = ColorPicker();
  final GlobalState globalState = Get.find<GlobalState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBar(text: "CHANGE PASSWORD", colors: colors, drawerLeading: true),
      drawer: drawer(
        colors: colors,
        currentActiveMenu: "Change Password",
        onTap: (route) => globalState.handleDrawerMenu(route),
      ),
      extendBodyBehindAppBar: true,
      body: GetBuilder<UserPasswordController>(builder: (builder) {
        return BackgroundLayout(
          showLogo: false,
          child: MainLayout(
            children: [
              title(title: "Change Password"),
              const Gap(10),
              FormAuth(
                formKey: formKey,
                horizontalPadding: 0,
                children: [
                  TextInputPassword(
                    focusNode: controller.newPasswordNode,
                    controller: controller.newPasswordController,
                    isObscure: controller.isObscureNew.value,
                    label: "New Password",
                    prefixIcon: Icons.password,
                    toggleObscure: () => controller.toggleObscure("new"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your new password";
                      }

                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }

                      if (value != controller.confirmPasswordController.text) {
                        return "Password does not match";
                      }

                      return null;
                    },
                  ),
                  const Gap(10),
                  TextInputPassword(
                    focusNode: controller.confirmPasswordNode,
                    controller: controller.confirmPasswordController,
                    isObscure: controller.isObscureConfirm.value,
                    label: "Confirm Password",
                    prefixIcon: Icons.password,
                    toggleObscure: () => controller.toggleObscure("confirm"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return;
                      }

                      if (value.length < 6) {
                        return;
                      }

                      if (value != controller.newPasswordController.text) {
                        return;
                      }

                      return null;
                    },
                  ),
                  const Gap(10),
                  GradientButton(
                    colors: [colors.green, colors.greenDark],
                    onPressed: () => controller.handleUpdatePassword(formKey),
                    text: "Update",
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
